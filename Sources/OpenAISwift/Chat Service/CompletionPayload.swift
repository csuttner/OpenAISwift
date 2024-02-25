//
//  CompletionPayload.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct CompletionPayload: Encodable {
    public let messages: [Message]
    public let model: Model
    public let maxTokens: Int?
    public let stream: Bool?

    public init(messages: [Message], model: Model, maxTokens: Int? = nil, stream: Bool? = nil) {
        self.messages = messages
        self.model = model
        self.maxTokens = maxTokens
        self.stream = stream
    }
}
