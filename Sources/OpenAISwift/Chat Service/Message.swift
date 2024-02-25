//
//  Message.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public struct Message: Codable {
    public let role: Role?

    let content: Content?

    public var textContent: String? {
        switch content {
        case let .string(string):
            string

        case let .array(array):
            array.first { $0.type == .text }?.text
            
        default:
            nil
        }
    }

    public var imageContent: String? {
        guard case let .array(array) = content
        else {
            return nil
        }

        return array.first { $0.type == .image }?.imageUrl?.url
    }

    public init(role: Role, text: String, image: String? = nil) {
        self.role = role

        if let image, !image.isEmpty {
            content = .array([
                ContentItem(text: text),
                ContentItem(image: image),
            ])
        } else {
            content = .string(text)
        }
    }
}
