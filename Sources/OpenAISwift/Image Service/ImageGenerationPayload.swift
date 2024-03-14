//
//  File.swift
//  
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public struct ImageGenerationPayload: Encodable {
    public let prompt: String
    public let model: Model
    
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int
    public let quality: ImageQuality
    public let responseFormat: ImageFormat
    public let size: ImageSize
    public let style: ImageStyle
    public let user: String?
    
    public init(
        prompt: String,
        model: Model = .dallE2,
        n: Int = 1,
        quality: ImageQuality = .standard,
        responseFormat: ImageFormat = .url,
        size: ImageSize = .largeSquare,
        style: ImageStyle = .vivid,
        user: String? = nil
    ) {
        self.prompt = prompt
        self.model = model
        self.n = n
        self.quality = quality
        self.responseFormat = responseFormat
        self.size = size
        self.style = style
        self.user = user
    }
}
