//
//  ComicsModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation
struct ComicsModel: Codable {
    let id, digitalID, title, issueNumber: String
    let variantDescription, description, modified, isbn: String
    let upc, diamondCode, ean, issn: String
    let format, pageCount: String
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants, collections, collectedIssues: [Series]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators, characters: Characters
    let stories: Stories
    let events: Events

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription, description, modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available, returned, collectionURI: String
    let items: [CharactersItem]
}

// MARK: - CharactersItem
struct CharactersItem: Codable {
    let resourceURI, name, role: String
}

// MARK: - Series
struct Series: Codable {
    let resourceURI, name: String
}

// MARK: - DateElement
struct DateElement: Codable {
    let type, date: String
}

// MARK: - Events
struct Events: Codable {
    let available, returned, collectionURI: String
    let items: [Series]
}

// MARK: - Price
struct Price: Codable {
    let type, price: String
}


// MARK: - TextObject
struct TextObject: Codable {
    let type, language, text: String
}

