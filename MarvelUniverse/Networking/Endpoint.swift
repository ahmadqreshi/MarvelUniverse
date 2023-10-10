//
//  Endpoint.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import Foundation

enum Endpoint {
        
    case characters(name: String?, offset: Int)
    case comics(filter: String?, offset: Int)
    
    
    
    

    var urlEndpoint: String {
        switch self {
        case .characters:
            return "characters"
        case .comics:
            return "comics"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    
    var urlString: String {
        return "https://gateway.marvel.com:443/v1/public/\(self.urlEndpoint)"
    }
    
    var url: URL? {
        guard var urlComponents = URLComponents(string: urlString) else { return  nil}
        let apiKey = "c572858cf5d9d4e67ab06b7d82d9e827"
        switch self {
        case .characters(let name,let offset):
            urlComponents.queryItems = [
                URLQueryItem(name: "name", value: name),
                URLQueryItem(name: "offset", value: String(offset))
                
            ]
        case .comics(let filter, let offset):
            urlComponents.queryItems = [
                URLQueryItem(name: "dateDescriptor", value: filter),
                URLQueryItem(name: "offset", value: String(offset))
            ]
        }
        urlComponents.queryItems?.append(URLQueryItem(name: "apikey", value: apiKey))
        return urlComponents.url
    }
}
