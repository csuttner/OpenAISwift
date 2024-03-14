//
//  ServiceRouter.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

protocol ServiceRouter {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: [HTTPHeader] { get }
    var body: Encodable? { get }
}

extension ServiceRouter {
    var baseURL: String {
        "https://api.openai.com/v1"
    }
        
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path)
        else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = httpMethod.rawValue
        request.httpHeaders = httpHeaders

        if let body {
            request.httpBody = try JSONEncoder.shared.encode(body)
        }

        return request
    }
}
