//
//  ContentItem.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

enum ContentType: String, Codable {
    case text
    case image = "image_url"
}

struct ContentItem: Codable {
    let type: ContentType
    var text: String?
    var imageUrl: ImageURL?

    init(text: String) {
        type = .text
        self.text = text
    }

    init(image: String) {
        type = .image
        imageUrl = ImageURL(url: image)
    }
}

struct ImageURL {
    let url: String
    var detail: ImageDetail?
}

extension ImageURL: Codable {
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

enum ImageDetail: String, Codable {
    case low, high, auto
}
