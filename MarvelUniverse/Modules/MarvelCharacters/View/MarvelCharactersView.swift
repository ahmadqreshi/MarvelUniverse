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
                                        viewModel.shouldLoadData(id: index)
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        if viewModel.isMoreDataAvailable {
                            lastRowView
                        }
                    }
                }
            }
            
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search any Character")) {
            ForEach(searchResults, id: \.self) { result in
                Text("Are you looking for \(result)?").searchCompletion(result)
            }
        }
        .onChange(of: viewModel.searchText) { newValue in
            debugPrint(newValue)
        }
        .onSubmit(of: .search, runSearch)
    }
    
    var searchResults: [String] {
        if viewModel.searchText.isEmpty {
            return viewModel.history
        } else {
            return viewModel.history.filter { $0.contains(viewModel.searchText) }
        }
    }
    
    func runSearch() {
        viewModel.history.append(viewModel.searchText)
        viewModel.getData()
        debugPrint("Run Search")
    }
    
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            ProgressView()
        }
        .frame(height: 50)
    }
}

struct MarvelCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelCharactersView()
    }
}
