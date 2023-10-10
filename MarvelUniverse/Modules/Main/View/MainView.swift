//
//  ContentView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            MarvelCharactersView()
                .tabItem {
                    Image(systemName: "shareplay")
                    Text("Charcters")
                }
            
            MarvelComicsView()
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
