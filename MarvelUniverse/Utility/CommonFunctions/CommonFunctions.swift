//
//  CommonFunctions.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 14/10/23.
//

import Foundation

struct CommonFunctions {
    static func convertJsonFiletoDto<T: Decodable>(
        filename: String,
        success: @escaping (T) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let rawData: Data
        
        if let fileUrl = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                rawData = try Data(contentsOf: fileUrl)
            } catch {
                failure("Couldn't load \(filename) from main bundle:\n\(error)")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: rawData)
                success(decodedData)
            } catch {
                failure("Couldn't parse \(filename) as \(T.self):\n\(error)")
            }
        } else {
            failure("Couldn't find \(filename) in main bundle.")
        }
    }
}

