//
//  ChatCompletionChoice.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

public struct ChatCompletionChoice: Decodable {
    public let index: Int
    public let delta: ChatMessage?
    public let message: ChatMessage?
    public let logprobs: String?
    public let finishReason: String?

    public init(index: Int = 0, delta: ChatMessage? = nil, message: ChatMessage? = nil, logprobs: String? = nil, finishReason: String? = nil) {
        self.index = index
        self.delta = delta
        self.message = message
        self.logprobs = logprobs
        self.finishReason = finishReason
    }
}
