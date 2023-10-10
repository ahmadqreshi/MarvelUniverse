//
//  MarvelCharactersView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MarvelCharactersView: View {
    
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top),
    ]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(0...20, id: \.self) { _ in
                            CharacterCardView()
                                .padding(.bottom, 16)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct MarvelCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelCharactersView()
    }
}
