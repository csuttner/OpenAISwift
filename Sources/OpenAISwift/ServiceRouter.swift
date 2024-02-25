//
//  ServiceRouter.swift
//  OpenAI
//
//  Created by Clay Suttner on 2/10/24.
//

import Foundation

protocol ServiceRouter {
    func asURLRequest() throws -> URLRequest
}
