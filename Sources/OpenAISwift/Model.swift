//
//  AIModel.swift
//  OpenAI
//
//  Created by Clay Suttner on 4/23/23.
//

import Foundation

public enum Model: String, Codable {
    case gpt3_5Turbo = "gpt-3.5-turbo"
    case gpt4VisionPreview = "gpt-4-vision-preview"
    case dallE2 = "dall-e-2"
    case dallE3 = "dall-e-3"
}
