//
//  ImageVariationPayload.swift
//
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public struct ImageVariationPayload: Encodable {
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
    
    var formData: Data {
        let data = NSMutableData()
        return data as Data
    }
}
