//
//  ImageVariationPayload.swift
//
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public struct ImageVariationPayload: MultipartFormEncodable {
    public let prompt: String
    public let image: Data
    public let model: Model
    
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int
    public let size: ImageSize
    public let user: String?

    public init(
        prompt: String,
        image: Data,
        model: Model = .dallE2,
        n: Int = 1,
        size: ImageSize = .largeSquare,
        user: String? = nil
    ) {
        self.prompt = prompt
        self.image = image
        self.model = model
        self.n = n
        self.size = size
        self.user = user
    }
    
    var fields: [MultipartFormDataField] {
        [
            .init(name: "prompt", data: prompt.data(using: .utf8)),
            .init(name: "image", filename: "image.png", mimeType: "image/png", data: image),
            .init(name: "model", data: model.rawValue.data(using: .utf8)),
            .init(name: "n", data: String(n).data(using: .utf8)),
            .init(name: "size", data: size.rawValue.data(using: .utf8)),
            .init(name: "user", data: user?.data(using: .utf8))
        ]
        .compactMap { $0 }
    }
}
