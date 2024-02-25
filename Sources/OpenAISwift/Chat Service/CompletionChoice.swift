//
//  CompletionChoice.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

public struct CompletionChoice: Decodable {
    public let index: Int
    public let delta: Message?
    public let message: Message?
    public let logprobs: String?
    public let finishReason: String?

    public init(index: Int = 0, delta: Message? = nil, message: Message? = nil, logprobs: String? = nil, finishReason: String? = nil) {
        self.index = index
        self.delta = delta
        self.message = message
        self.logprobs = logprobs
        self.finishReason = finishReason
    }
}
