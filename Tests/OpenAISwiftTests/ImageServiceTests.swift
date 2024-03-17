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

        let payload = ImageGenerationPayload(
            prompt: "an image of a surfer"
        )
        
        let response = try await service
            .fetchImageGeneration(payload: payload)
        
        XCTAssertNotNil(response.data.first?.url)
    }
    
    func test_fetchImageEdit() async throws {
        let service = ImageService()
        
        let payload = ImageEditPayload(
            image: imageData("Wave"),
            prompt: "a surfer on the wave",
            mask: imageData("WaveMask")
        )
        
        let response = try await service
            .fetchImageEdit(payload: payload)
        
        XCTAssertNotNil(response.data.first?.url)
    }
    
    func test_fetchImageVariation() async throws {
        let service = ImageService()
        
        let payload = ImageVariationPayload(
            image: imageData("Wave")
        )
        
        let response = try await service
            .fetchImageVariation(payload: payload)
        
        XCTAssertNotNil(response.data.first?.url)
    }
    
    private func imageData(_ name: String) -> Data {
        UIImage(
            named: name,
            in: Bundle.module,
            with: .none
        )!.pngData()!
    }
}
