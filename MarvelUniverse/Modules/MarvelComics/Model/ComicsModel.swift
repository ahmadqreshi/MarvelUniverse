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
