//
//  ImageService.swift
//
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public class ImageService: Fetchable {
    public func fetchImageGeneration(payload: ImageGenerationPayload) async throws -> ImageResponse {
        try await fetch(ImageServiceRouter.generation(payload))
    }
    
    public func fetchImageEdit(payload: ImageEditPayload) async throws -> ImageResponse {
        try await upload(payload.formData, router: ImageServiceRouter.edit)
    }
    
    public func fetchImageVariation(payload: ImageVariationPayload) async throws -> ImageResponse {
        try await upload(payload.formData, router: ImageServiceRouter.variation)
    }
}

enum ImageServiceRouter: ServiceRouter {
    case generation(ImageGenerationPayload)
    case edit
    case variation
    
    var path: String {
        switch self {
        case .generation:
            "/images/generations"
            
        case .edit:
            "/images/edits"
            
        case .variation:
            "/images/variations"
        }
    }
    
    var httpMethod: HTTPMethod {
        .post
    }
    
    var httpHeaders: [HTTPHeader] {
        switch self {
        case .generation:
            [.contentTypeJSON, .authorization]
            
        case .edit, .variation:
            [.contentTypeFormData, .authorization]
        }
        
    }
    
    var body: Encodable? {
        switch self {
        case let .generation(payload):
            return payload
            
        default:
            return nil
        }
    }
}
