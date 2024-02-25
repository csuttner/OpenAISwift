//
//  DetailedError.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/11/24.
//

import Foundation

public protocol DetailedError: Error {
    var detailedErrorType: String { get }
    var detailedDescription: String { get }
}
