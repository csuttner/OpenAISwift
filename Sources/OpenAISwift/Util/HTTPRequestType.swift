//
//  HTTPContentType.swift
//
//
//  Created by Clay Suttner on 3/15/24.
//

import Foundation

enum HTTPRequestType {
    case applicationJSON(Encodable)
    case multipartFormData(MultipartFormEncodable, String)
    
    var httpHeaders: [HTTPHeader] {
        switch self {
        case .applicationJSON:
            [
                HTTPHeader(field: "Authorization", value: "Bearer \(Auth.apiKey)"),
                HTTPHeader(field: "Content-Type", value: "application/json")
            ]

        case let .multipartFormData(_, boundary):
            [
                HTTPHeader(field: "Authorization", value: "Bearer \(Auth.apiKey)"),
                HTTPHeader(field: "Content-Type", value: "multipart/form-data; boundary=\(boundary)")
            ]
        }
    }
    
    var httpBody: Data? {
        switch self {
        case let .applicationJSON(payload):
            return try? JSONEncoder.shared.encode(payload)

        case let .multipartFormData(payload, boundary):
            return payload.formData(boundary: boundary)
        }
    }
}
