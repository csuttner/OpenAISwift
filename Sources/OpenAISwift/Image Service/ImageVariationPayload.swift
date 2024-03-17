//
//  ImageVariationPayload.swift
//
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public struct ImageVariationPayload: MultipartFormEncodable {
    public let image: Data
    public let model: Model
    
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int
    public let responseFormat: ImageFormat
    public let size: ImageSize
    public let user: String?

    public init(
        image: Data,
        model: Model = .dallE2,
        n: Int = 1,
        responseFormat: ImageFormat = .url,
        size: ImageSize = .largeSquare,
        user: String? = nil
    ) {
        self.image = image
        self.model = model
        self.n = n
        self.responseFormat = responseFormat
        self.size = size
        self.user = user
    }
    
    var fields: [MultipartFormDataField] {
        [
            .init(name: "image", filename: "image.png", mimeType: "image/png", data: image),
            .init(name: "model", data: model.rawValue.data(using: .utf8)),
            .init(name: "n", data: String(n).data(using: .utf8)),
            .init(name: "response_format", data: responseFormat.rawValue.data(using: .utf8)),
            .init(name: "size", data: size.rawValue.data(using: .utf8)),
            .init(name: "user", data: user?.data(using: .utf8))
        ]
        .compactMap { $0 }
    }
}
