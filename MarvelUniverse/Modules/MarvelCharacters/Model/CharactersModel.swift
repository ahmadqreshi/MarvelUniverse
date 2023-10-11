//
//  CharactersModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation

struct CharactersModel: Codable {
    let id, name, description, modified: String
    let resourceURI: String
    let urls: [URLElement]
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let events, series: Comics
}

// MARK: - Comics
struct Comics: Codable {
    let available, returned, collectionURI: String
    let items: [ComicsItem]
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI, name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available, returned, collectionURI: String
    let items: [StoriesItem]
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
// MARK: - URLElement
struct URLElement: Codable {
    let type, url: String
}
