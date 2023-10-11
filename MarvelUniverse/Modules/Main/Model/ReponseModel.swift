//
//  ReponseModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: DataModel<T>
    let etag: String
}


struct DataModel<T: Codable>: Codable {
    let offset, limit, total, count: String
    let results: [T]
}
