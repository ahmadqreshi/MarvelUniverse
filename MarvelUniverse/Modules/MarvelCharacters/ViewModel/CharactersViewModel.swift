//
//  CharactersViewModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation
class CharactersViewModel: ObservableObject {
    
    
    @Published var isLoading: Bool = false
    @Published var characters: [CharactersModel] = []
    
    init() {
        getData()
    }
    
    
    func getData() {
        CharactersDataRepository.shared.getCharacters(name: nil, offset: 0) { response in
            debugPrint(response)
        } failure: { error in
            debugPrint(error)
        }
    }
}
