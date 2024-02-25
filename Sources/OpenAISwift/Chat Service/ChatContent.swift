//
//  ChatContent.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

enum ChatContent: Codable {
    case string(String)
    case array([ChatContentItem])

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .string(stringValue):
            try container.encode(stringValue)
        case let .array(arrayValue):
            try container.encode(arrayValue)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let string = try? container.decode(String.self) {
            self = .string(string)
        }

        else if let array = try? container.decode([ChatContentItem].self) {
            self = .array(array)
        }

        else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "ChatContent could not be decoded"
            )
        }
    }
}
