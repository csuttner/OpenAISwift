//
//  Fetchable.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

protocol Fetchable {}

extension Fetchable {
    func fetch<T: Decodable>(_ router: ServiceRouter) async throws -> T {
        let request = try router.asURLRequest()

        let (data, response) = try await URLSession.shared.data(for: request)

        return try decode(data: data, response: response)
    }
    
    func upload<T: Decodable>(_ formData: Data, router: ServiceRouter) async throws -> T {
        let request = try router.asURLRequest()
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: formData)
        
        return try decode(data: data, response: response)
    }
    
    private func decode<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if let apiError = APIError(data: data, httpResponse: httpResponse) {
            throw apiError
        }
        
        return try JSONDecoder.shared.decode(T.self, from: data)
    }
    
    func stream<T: Decodable>(_ router: ServiceRouter) async -> AsyncThrowingStream<T, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let bytes = try await fetchBytes(router)

                    for try await buffer in bytes.lines {
                        parse(buffer).forEach { continuation.yield($0) }
                    }

                    continuation.finish()

                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    private func fetchBytes(_ router: ServiceRouter) async throws -> URLSession.AsyncBytes {
        let request = try router.asURLRequest()
        
        let (bytes, response) = try await URLSession.shared.bytes(for: request)
        
        guard response is HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        return bytes
    }
    
    private func parse<T: Decodable>(_ buffer: String) -> [T] {
        buffer
            .components(separatedBy: "data: ")
            .filter { $0 != "data: " }
            .compactMap { $0.data(using: .utf8) }
            .compactMap { try? JSONDecoder.shared.decode(T.self, from: $0) }
    }
}
