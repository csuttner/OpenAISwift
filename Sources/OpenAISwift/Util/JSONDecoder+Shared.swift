//
//  JSONDecoder+Shared.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

extension JSONDecoder {
    static let shared: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
