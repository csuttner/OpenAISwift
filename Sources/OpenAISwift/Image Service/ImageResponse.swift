//
//  ImageResponse.swift
//  
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public struct ImageResponse: Decodable {
    public let created: Date
    public let data: [ImageData]
}

public struct ImageData: Decodable {
    public let url: URL?
    public let b64Json: String?
    public let revisedPrompt: String?
}
