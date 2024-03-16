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

    var path: String {
        "/chat/completions"
    }

    var httpMethod: HTTPMethod {
        .post
    }
    
    var requestType: HTTPRequestType {
        switch self {
        case
            let .completion(payload),
            let .completionStream(payload):
            .applicationJSON(payload)
        }
    }
}
