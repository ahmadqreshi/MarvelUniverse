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
    @Published var offset: Int = 0
    @Published var isMoreDataAvailable: Bool = false
    @Published var searchText: String = ""
    
    var history: [String] = []
    init() {
        getData()
    }
    
    func getData() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.offset == 0 {
                strongSelf.isLoading = true
            } else {
                strongSelf.isMoreDataAvailable = true
            }
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            CharactersDataRepository.shared.getCharacters(name: strongSelf.searchText, offset: strongSelf.offset) { response in
                DispatchQueue.main.async {
                    strongSelf.isMoreDataAvailable = strongSelf.characters.count < response.data.count
                    if strongSelf.characters.isEmpty {
                        strongSelf.characters = response.data.results
                    } else {
                        strongSelf.characters.append(contentsOf: response.data.results)
                    }
                    strongSelf.isLoading = false
                }
            } failure: { error in
                debugPrint(error)
            }
        }
    }
    
    
    func shouldLoadData(id: Int)  {
        if id == characters.count - 1 {
            offset += 1
            getData()
        }
    }
}
