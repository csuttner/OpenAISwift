//
//  ChatService.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public class ChatService: Fetchable {
    public init() {}
    
    public func fetchChatCompletion(text: String, image: String?, history: [Message]) async throws -> CompletionResponse {
        try await fetch(ChatServiceRouter.completion(text, image, history))
    }
    
    public func streamChatCompletion(text: String, image: String?, history: [Message]) async -> AsyncThrowingStream<CompletionChunk, Error> {
        await stream(ChatServiceRouter.completionStream(text, image, history))
    }
}

enum ChatServiceRouter: ServiceRouter {
    case completion(String, String?, [Message])
    case completionStream(String, String?, [Message])

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
        case .completion(let prompt, let image, var history):
            history.append(Message(role: .user, text: prompt, image: image))
            return CompletionRequest(messages: history, model: .gpt4VisionPreview)

        case .completionStream(let prompt, let image, var history):
            history.append(Message(role: .user, text: prompt, image: image))
            return CompletionRequest(
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
            .completion,
            .completionStream:
            "/chat/completions"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case 
            .completion,
            .completionStream:
            .post
        }
    }
}
