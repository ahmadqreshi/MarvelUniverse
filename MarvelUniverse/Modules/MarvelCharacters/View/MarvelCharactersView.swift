//
//  MarvelCharactersView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MarvelCharactersView: View {
    
    @StateObject var viewModel: CharactersViewModel = CharactersViewModel()
    
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top),
    ]
    @State private var searchText = ""
    let history = ["Holly", "Josh", "Rhonda", "Ted"]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(0...20, id: \.self) { _ in
                            CharacterCardView()
                                .padding(.bottom, 32)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search any Character")) {
            ForEach(searchResults, id: \.self) { result in
                Text("Are you looking for \(result)?").searchCompletion(result)
            }
        }
        .onChange(of: searchText) { newValue in
            debugPrint(newValue)
        }
        .onSubmit(of: .search, runSearch)
        
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return history
        } else {
            return history.filter { $0.contains(searchText) }
        }
    }
    
    
    func runSearch() {
        debugPrint("Run Search")
    }
}

struct MarvelCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelCharactersView()
    }
}
