//
//  ImageServiceTests.swift
//  
//
//  Created by Clay Suttner on 3/16/24.
//

import XCTest
import UIKit
@testable import OpenAISwift

final class ImageServiceTests: XCTestCase {
    
    override func setUp() {
        Auth.apiKey = Secrets.apiKey
    }
    
    override func tearDown() {
        Auth.apiKey = ""
    }

    func test_fetchImageGeneration() async throws {
        let service = ImageService()
        let payload = ImageGenerationPayload(prompt: "an image of a surfer")
        
        let response = try await service.fetchImageGeneration(payload: payload)
        
        XCTAssertNotNil(response.data.first?.url)
    }
    
    func test_fetchImageEdit() async throws {
        
    }
    
    func test_fetchImageVariation() async throws {
        let service = ImageService()
        let image = UIImage(named: "Wave", in: Bundle.module, with: .none)!
        let payload = ImageVariationPayload(image: image.pngData()!)
        
        let response = try await service.fetchImageVariation(payload: payload)
        
        XCTAssertNotNil(response.data.first?.url)
    }
}
