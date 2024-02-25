//
//  ChatService.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public class ChatService: Fetchable {
    public init() {}
    
    public func fetchChatCompletion(payload: CompletionPayload) async throws -> CompletionResponse {
        try await fetch(ChatServiceRouter.completion(payload))
    }
    
    public func streamChatCompletion(payload: CompletionPayload) async -> AsyncThrowingStream<CompletionChunk, Error> {
        await stream(ChatServiceRouter.completionStream(payload))
    }
}

enum ChatServiceRouter: ServiceRouter {
    case completion(CompletionPayload)
    case completionStream(CompletionPayload)

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
        case
            let .completion(payload),
            let .completionStream(payload):
            return payload
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
