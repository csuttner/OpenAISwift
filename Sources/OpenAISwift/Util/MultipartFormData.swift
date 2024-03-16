//
//  File.swift
//  
//
//  Created by Clay Suttner on 3/15/24.
//

import Foundation

protocol MultipartFormEncodable {
    var fields: [MultipartFormDataField] { get }
}

extension MultipartFormEncodable {
    func formData(boundary: String) -> Data {
        let formData = NSMutableData()

        for field in fields {
            formData.append(field.multipartFormData(boundary: boundary))
        }

        formData.append("--\(boundary)--\r\n")

        return formData as Data
    }
}

struct MultipartFormDataField {
    let name: String
    let filename: String?
    let mimeType: String?
    let data: Data
    
    init?(name: String, filename: String? = nil, mimeType: String? = nil, data: Data?) {
        if let data {
            self.name = name
            self.filename = filename
            self.mimeType = mimeType
            self.data = data
        } else {
            return nil
        }
    }
    
    func multipartFormData(boundary: String) -> Data {
        let formData = NSMutableData()

        formData.append("--\(boundary)\r\n")
        formData.append("Content-Disposition: form-data; name=\"\(name)\"")

        if let filename = filename {
            formData.append("; filename=\"\(filename)\"")
        }

        formData.append("\r\n")

        if let mimeType = mimeType {
            formData.append("; Content-Type: \(mimeType)\r\n")
        }

        formData.append("\r\n")
        formData.append(data)
        formData.append("\r\n")

        return formData as Data
    }
}

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
