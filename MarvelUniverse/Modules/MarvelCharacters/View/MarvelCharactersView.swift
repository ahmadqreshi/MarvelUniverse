//
//  MarvelCharactersView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MarvelCharactersView: View {
    
    @ObservedObject private var viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    @Environment(\.isSearching) private var isSearching: Bool
   
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top),
    ]
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                LoaderView()
            } else {
                VStack {
                    
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns) {
                            ForEach(Array(viewModel.characters.enumerated()), id: \.offset) { index, character in
                                CharacterCardView(character: character)
                                    .onAppear {
                                        viewModel.shouldLoadData(id: index, limit: viewModel.characters.count)
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        if viewModel.isMoreDataAvailable {
                            LastRowView()
                        }
                        
                        if viewModel.isResultsEmpty {
                            Text("No Results Found!")
                        }
                    }
                }
                
            }
            
        }
        .onAppear {
            viewModel.getData()
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search any Character")) {
            ForEach(viewModel.searchResults, id: \.self) { result in
                Text("Are you looking for \(result)?").searchCompletion(result)
            }
        }
        .onChange(of: viewModel.searchText) { value in
            if value.isEmpty && !isSearching {
                viewModel.cancelButtonPressed()
            }
        }
        .onSubmit(of: .search, viewModel.searchQuery)
    }
}

struct MarvelCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelCharactersView(viewModel: CharactersViewModel())
    }
}
