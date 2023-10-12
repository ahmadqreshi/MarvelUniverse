//
//  ReponseModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation


struct ResponseModel<T: Codable>: Codable {
    let status: String
    let data: DataModel<T>
    let code: Int
    let copyright, attributionText, attributionHTML, etag: String
}

// MARK: - DataClass
struct DataModel<T: Codable>: Codable {
    let results: [T]
    let offset, count, total, limit: Int
}
