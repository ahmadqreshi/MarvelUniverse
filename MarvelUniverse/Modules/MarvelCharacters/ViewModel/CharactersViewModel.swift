//
//  CharactersViewModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation

class CharactersViewModel: ObservableObject {
    
    private let dataRepo: CharactersDataServiceProtocol
    
    @Published private(set) var characters: [CharactersModel] = [] // main data source for populating data
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var offset: Int = 0
    @Published private(set) var isMoreDataAvailable: Bool = false
    @Published private(set) var isResultsEmpty: Bool = false
    @Published var searchText: String = ""
    
    private(set) var medium: FetchDataMedium = .normal
    private var isViewLoaded: Bool = false
    private var fetchedCharacters: [CharactersModel] = []
    private var searchedCharacters: [CharactersModel] = []
    
    var history: [String] = [] // to show history of results
    var searchResults: [String] {
        if searchText.isEmpty {
            return history
        } else {
            return history.filter { $0.contains(searchText) }
        }
    }
    
    
    init(dataRepo: CharactersDataServiceProtocol = CharactersDataRepository()) {
        self.dataRepo = dataRepo
    }
    
    
    func getData() {
        if !isViewLoaded {
            fetchCharactersData()
            isViewLoaded = true
        }
    }
    
     
    func shouldLoadData(id: Int, limit: Int)  {
        if id == limit - 1 {
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
        isLoading = true
        fetchCharactersData()
    }
    
    func cancelButtonPressed() {
        medium = .normal
        fetchCharactersData()
    }
    
    
    private func fetchCharactersData() {
       DispatchQueue.main.async { [weak self] in
           guard let strongSelf = self else { return }
           if strongSelf.offset == 0 {
               strongSelf.isLoading = true
           }
       }
       
       DispatchQueue.global(qos: .userInitiated).async { [weak self] in
           guard let strongSelf = self else { return }
           strongSelf.dataRepo.getCharacters(name: strongSelf.searchText.lowercased(), offset: strongSelf.offset) { response in
               debugPrint(strongSelf.offset)
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
    
}
