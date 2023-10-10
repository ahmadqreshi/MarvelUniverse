//
//  MarvelCharactersView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MarvelCharactersView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("Grid of Characters")
        }
    }
}

struct MarvelCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelCharactersView()
    }
}
