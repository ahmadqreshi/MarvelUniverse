////
////  CharactersModel.swift
////  MarvelUniverse
////
////  Created by Ahmad Qureshi on 11/10/23.
////
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
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
