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
        try await fetch(ImageServiceRouter.edit(payload))
    }
    
    public func fetchImageVariation(payload: ImageVariationPayload) async throws -> ImageResponse {
        try await fetch(ImageServiceRouter.variation(payload))
    }
}

enum ImageServiceRouter: ServiceRouter {
    case generation(ImageGenerationPayload)
    case edit(ImageEditPayload)
    case variation(ImageVariationPayload)

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
    
    var requestType: HTTPRequestType {
        switch self {
        case let .generation(payload):
            .applicationJSON(payload)
            
        case let .edit(payload):
            .multipartFormData(payload, UUID().uuidString)
            
        case let .variation(payload):
            .multipartFormData(payload, UUID().uuidString)
        }
    }
}
