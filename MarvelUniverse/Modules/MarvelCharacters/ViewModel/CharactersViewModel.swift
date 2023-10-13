//
//  CharactersViewModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation

class CharactersViewModel: ObservableObject {
    
    
    @Published var isLoading: Bool = false
    
    @Published var characters: [CharactersModel] = [] // main data source for populating data
    
    @Published var fetchedCharacters: [CharactersModel] = []
    @Published var searchedCharacters: [CharactersModel] = []
    
    var medium: FetchDataMedium = .normal
    @Published var offset: Int = 0
    @Published var isMoreDataAvailable: Bool = false
    @Published var searchText: String = ""
    @Published var isResultsEmpty: Bool = false
    
    var history: [String] = []
    init() {
        fetchCharactersData()
    }
    
    func fetchCharactersData() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.offset == 0 {
                strongSelf.isLoading = true
            } else  {
                strongSelf.isMoreDataAvailable = true
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            CharactersDataRepository.shared.getCharacters(name: strongSelf.searchText, offset: strongSelf.offset) { response in
                DispatchQueue.main.async {
                    strongSelf.isMoreDataAvailable = strongSelf.characters.count < response.data.count
                    switch strongSelf.medium {
                    case .normal:
                        if strongSelf.fetchedCharacters.isEmpty {  //handle pagination by checking list and appending items if not empty
                            strongSelf.fetchedCharacters = response.data.results
                        } else {
                            strongSelf.fetchedCharacters.append(contentsOf: response.data.results)
                        }
                        strongSelf.characters = strongSelf.fetchedCharacters
                    case .query:
                        if strongSelf.searchedCharacters.isEmpty { //handle pagination by checking list and appending items if not empty
                            strongSelf.searchedCharacters = response.data.results
                        } else {
                            strongSelf.searchedCharacters.append(contentsOf: response.data.results)
                        }
                        strongSelf.characters = strongSelf.searchedCharacters
                    }
                    strongSelf.isLoading = false
                    strongSelf.isResultsEmpty = strongSelf.characters.isEmpty
                    strongSelf.isMoreDataAvailable = !strongSelf.characters.isEmpty
                }
            } failure: { error in
                debugPrint(error)
            }
        }
    }
    

    
    func shouldLoadData(id: Int)  {
        if id == characters.count - 1 {
            offset += 1
            fetchCharactersData()
        }
    }
    
    
    func searchQuery() {
        searchedCharacters.removeAll()
        if !history.contains(searchText) {
            history.append(searchText)
        }
        medium = .query
        fetchCharactersData()
    }
    
}
