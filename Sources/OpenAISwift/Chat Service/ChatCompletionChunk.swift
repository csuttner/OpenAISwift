//
//  ChatCompletionChunk.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

public struct ChatCompletionChunk: Decodable {
    public let id: String
    public let object: String
    public let created: Date
    public let model: String
    public let systemFingerprint: String?
    public let choices: [ChatCompletionChoice]
    
    public init(id: String = "", object: String = "", created: Date = Date(), model: String = "", systemFingerprint: String = "", choices: [ChatCompletionChoice]) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.systemFingerprint = systemFingerprint
        self.choices = choices
    }
}

struct ChatCompletionStreamResponse: Decodable {
    let data: ChatCompletionChunk
}
