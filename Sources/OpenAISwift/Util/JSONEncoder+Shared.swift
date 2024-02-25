//
//  JSONEncoder+Shared.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

extension JSONEncoder {
    static let shared: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
}
