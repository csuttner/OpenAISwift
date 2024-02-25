//
//  ChatContentItem.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

enum ChatContentType: String, Codable {
    case text
    case image = "image_url"
}

struct ChatContentItem: Codable {
    let type: ChatContentType
    var text: String?
    var imageUrl: ChatImageUrl?

    init(text: String) {
        type = .text
        self.text = text
    }

    init(image: String) {
        type = .image
        imageUrl = ChatImageUrl(url: image)
    }
}

struct ChatImageUrl {
    let url: String
    var detail: ChatImageDetail?
}

extension ChatImageUrl: Codable {
    private static let prefix = "data:image/jpeg;base64,"

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Self.prefix + url)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let urlString = try container.decode(String.self)

        if let base64Index = urlString.range(of: Self.prefix)?.upperBound {
            let base64String = String(urlString[base64Index...])
            url = base64String
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid Image format")
        }
    }
}

enum ChatImageDetail: String, Codable {
    case low, high, auto
}
