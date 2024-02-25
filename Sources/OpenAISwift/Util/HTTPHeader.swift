//
//  HTTPHeader.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

struct HTTPHeader {
    let field: String
    let value: String

    static let contentType = HTTPHeader(field: "Content-Type", value: "application/json")
    static let authorization = HTTPHeader(field: "Authorization", value: "Bearer \(Secrets.apiKey)")
}

extension URLRequest {
    var httpHeaders: [HTTPHeader] {
        get {
            allHTTPHeaderFields?.compactMap { HTTPHeader(field: $0, value: $1) } ?? []
        }
        set {
            newValue.forEach { setValue($0.value, forHTTPHeaderField: $0.field) }
        }
    }
}
