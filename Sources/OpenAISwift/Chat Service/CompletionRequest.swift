//
//  CompletionRequest.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

struct CompletionRequest: Encodable {
    let messages: [Message]
    let model: Model
    let maxTokens: Int?
    let stream: Bool?

    init(messages: [Message], model: Model, maxTokens: Int? = nil, stream: Bool? = nil) {
        self.messages = messages
        self.model = model
        self.maxTokens = maxTokens
        self.stream = stream
    }
}
