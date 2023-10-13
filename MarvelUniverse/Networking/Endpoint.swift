//
//  Endpoint.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import Foundation
import CryptoKit

enum Endpoint {
    
    case characters(name: String?, offset: Int)
    case comics(dateDescriptor: String?, offset: Int)

}


//MARK: - Request Protocol Methods
extension Endpoint {
    var path: String {
        "v1/public"
    }
    
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
        return "\(APIConstants.baseURL)/\(path)/\(self.urlEndpoint)"
    }
    
    
    var urlParams: [String: String?] {
        switch self {
        case .characters(let searchKey, let offset):
            var params = ["offset": "\(offset)", "limit": "\(APIConstants.defaultLimit)"]
            if let searchKey, !searchKey.isEmpty {
                params["nameStartsWith"] = searchKey
            }
            return params
        case .comics(let dateDescriptor, let offset):
            var params = ["offset": "\(offset)", "limit": "\(APIConstants.defaultLimit)"]
            if let dateDescriptor, !dateDescriptor.isEmpty {
                params["dateDescriptor"] = dateDescriptor
            }
            return params
        }
    }
        
    
    
    
    var url: URL? {
        guard var urlComponents = URLComponents(string: urlString) else { return  nil}
        
        let timeStamp = String(Date().timeIntervalSince1970)
        let hashString = "\(timeStamp)\(APIConstants.privateKey)\(APIConstants.publicKey)"
        let hash = Insecure.MD5.hash(data: hashString.data(using: .utf8) ?? Data()).map {String(format: "%02hhx", $0)}.joined()
        

        var queryParamsList: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: APIConstants.publicKey),
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash)
        ]

        if !urlParams.isEmpty {
            queryParamsList.append(contentsOf: urlParams.map { URLQueryItem(name: $0, value: $1) })
        }
        
        urlComponents.queryItems = queryParamsList
        
        return urlComponents.url
    }
}
