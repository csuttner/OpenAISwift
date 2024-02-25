//
//  URLError+DetailedError.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

extension URLError: DetailedError {
    public var detailedErrorType: String {
        OpenAIConstants.Error.urlError
    }

    public var detailedDescription: String {
        localizedDescription
    }
}
