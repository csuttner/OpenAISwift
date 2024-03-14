//
//  ImageFormat.swift
//  
//
//  Created by Clay Suttner on 3/13/24.
//

import Foundation

public enum ImageFormat: String, Encodable {
    case url
    case base64JSON = "b64_json"
}
