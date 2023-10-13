//
//  JsonFiles.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 14/10/23.
//

import Foundation

enum JsonFiles: String {
    case charactersResponse = "CharactersApiResponse"
    case comicsReponse = "ComicsApiResponse"
    var fileName: String {
        self.rawValue
    }
}
