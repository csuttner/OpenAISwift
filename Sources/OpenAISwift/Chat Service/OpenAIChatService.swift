//
//  OpenAIChatService.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public class OpenAIChatService: Fetchable {
    public init() {}

    public func fetchChatCompletion(text: String, image: String?, history: [ChatMessage]) async throws -> ChatCompletionResponse {
        try await fetch(ChatServiceRouter.chatCompletion(text, image, history))
    }
    
    public func streamChatCompletion(text: String, image: String?, history: [ChatMessage]) async -> AsyncThrowingStream<ChatCompletionChunk, Error> {
        await stream(ChatServiceRouter.chatCompletionStream(text, image, history))
    }
}

enum ChatServiceRouter: ServiceRouter {
    case chatCompletion(String, String?, [ChatMessage])
    case chatCompletionStream(String, String?, [ChatMessage])

    private static let baseURL = "https://api.openai.com/v1"

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: Self.baseURL + path)
        else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = httpMethod.rawValue
        request.httpHeaders = httpHeaders

        if let body {
            request.httpBody = try JSONEncoder.shared.encode(body)
        }

        return request
    }

    var body: Encodable? {
        switch self {
        case .chatCompletion(let prompt, let image, var history):
            history.append(ChatMessage(role: .user, text: prompt, image: image))
            return ChatCompletionRequest(messages: history, model: .gpt4VisionPreview)

        case .chatCompletionStream(let prompt, let image, var history):
            history.append(ChatMessage(role: .user, text: prompt, image: image))
            return ChatCompletionRequest(
                messages: history,
                model: .gpt4VisionPreview,
                maxTokens: 1000,
                stream: true
            )
        }
    }

    var httpHeaders: [HTTPHeader] {
        [.contentType, .authorization]
    }

    var path: String {
        switch self {
        case
            .chatCompletion,
            .chatCompletionStream:
            "/chat/completions"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case 
            .chatCompletion,
            .chatCompletionStream:
            .post
        }
    }
}
