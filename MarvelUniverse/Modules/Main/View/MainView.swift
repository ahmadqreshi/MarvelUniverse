//
//  ContentView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var marvelCharactersViewModel: CharactersViewModel = CharactersViewModel(dataRepo: CharactersDataRepository())
    @StateObject private var marvelComicsViewModel: ComicsViewModel = ComicsViewModel(dataRepo: ComicsDataRepository())
    
    
    var body: some View {
        TabView {
            MarvelCharactersView(viewModel: marvelCharactersViewModel)
                .tabItem {
                    Image(systemName: "shareplay")
                    Text("Charcters")
                }
            
            MarvelComicsView(viewModel: marvelComicsViewModel)
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
        }
        .accentColor(.red)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
