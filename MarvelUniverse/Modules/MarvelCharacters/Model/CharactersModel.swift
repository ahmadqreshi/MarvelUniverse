//
//  CharactersModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation

struct CharactersModel: Codable, Identifiable {
    
    let thumbnail: Thumbnail?
    let id: Int?
    let stories: Stories?
    let comics, series, events: Comics?
    let urls: [URLElement]?
    let name, resourceURI, description: String?
    
}

// MARK: - Comics
struct Comics: Codable {
    let returned, available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let name, resourceURI: String?
}

// MARK: - Stories
struct Stories: Codable {
    let returned, available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let name, resourceURI: String?
    let type: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String?
    let url: String?
}




extension CharactersModel {
    static func dummyData() -> CharactersModel {
        return CharactersModel(
            thumbnail: nil,
            id: nil,
            stories: nil,
            comics: nil,
            series: nil,
            events: nil,
            urls: nil,
            name: "Captain America",
            resourceURI: nil,
            description: "he is the greatest avengers and just a human being with super powers")
    }
}
