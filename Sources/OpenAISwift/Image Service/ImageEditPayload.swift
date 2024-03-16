//
//  ImageEditPayload.swift
//  
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public struct ImageEditPayload: MultipartFormEncodable {
    
    /// The image to edit. Must be a valid PNG file, less than 4MB, and square.
    /// If mask is not provided, image must have transparency, which will be used as the mask.
    public let image: Data
    public let prompt: String
    public let mask: Data?
    public let model: Model
    
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int
    public let size: ImageSize
    public let responseFormat: ImageFormat
    public let user: String?
    
    public init(
        image: Data,
        prompt: String,
        mask: Data? = nil,
        model: Model = .dallE2,
        n: Int = 1,
        size: ImageSize = .largeSquare,
        responseFormat: ImageFormat = .url,
        user: String? = nil
    ) {
        self.image = image
        self.prompt = prompt
        self.mask = mask
        self.model = model
        self.n = n
        self.size = size
        self.responseFormat = responseFormat
        self.user = user
    }
    
    var fields: [MultipartFormDataField] {
        [
            .init(name: "image", filename: "image.png", mimeType: "image/png", data: image),
            .init(name: "prompt", data: prompt.data(using: .utf8)),
            .init(name: "mask", filename: "mask.png", mimeType: "image/png", data: mask),
            .init(name: "model", data: model.rawValue.data(using: .utf8)),
            .init(name: "n", data: String(n).data(using: .utf8)),
            .init(name: "size", data: size.rawValue.data(using: .utf8)),
            .init(name: "response_format", data: responseFormat.rawValue.data(using: .utf8)),
            .init(name: "user", data: user?.data(using: .utf8))
        ]
        .compactMap { $0 }
    }
}
