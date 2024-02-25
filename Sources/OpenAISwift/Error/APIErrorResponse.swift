//
//  APIErrorResponse.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

struct APIErrorResponse: Decodable {
    let error: ErrorMessage
}

struct ErrorMessage: Decodable {
    let message: String
}
