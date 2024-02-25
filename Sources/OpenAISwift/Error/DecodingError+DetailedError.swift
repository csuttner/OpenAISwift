//
//  DecodingError+DetailedError.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

extension DecodingError: DetailedError {
    public var detailedErrorType: String {
        OpenAIConstants.Error.decodingError
    }

    public var detailedDescription: String {
        switch self {
        case let .typeMismatch(type, context):
            "Type '\(type)' mismatch: \(context.formattedDescription)"

        case let .valueNotFound(value, context):
            "Value '\(value)' not found: \(context.formattedDescription)"

        case let .keyNotFound(codingKey, context):
            "Key '\(codingKey)' not found: \(context.formattedDescription)"

        case let .dataCorrupted(context):
            context.debugDescription

        default:
            "Unknown"
        }
    }
}

extension DecodingError.Context {
    var formattedDescription: String {
        "\(debugDescription)\n\ncodingPath: \(codingPath.map(\.stringValue).joined(separator: ", "))"
    }
}
