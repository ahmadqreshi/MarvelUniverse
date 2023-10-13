//
//  ComicsModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation
struct ComicsModel: Codable {
    let prices: [Price]?
    let thumbnail: Thumbnail?
    let title, diamondCode, issn: String?
    let images: [Thumbnail]?
    let id, pageCount,issueNumber, digitalId : Int?
    let resourceURI: String?
    let variantDescription: String?
}

struct Price: Codable {
    let type: String
    let price: Double
}



extension ComicsModel {
    
    static func dummyData() -> ComicsModel {
        return ComicsModel(
            prices: [Price(type: "", price: 5.66)],
            thumbnail: nil,
            title: "Avengers",
            diamondCode: nil,
            issn: nil,
            images: nil,
            id: nil,
            pageCount: 120,
            issueNumber: nil,
            digitalId: nil,
            resourceURI: nil,
            variantDescription: nil)
    }
}
