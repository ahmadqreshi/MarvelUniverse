//
//  MarvelComicsView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MarvelComicsView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("Grid of Comics")
        }
    }
}

struct MarvelComicsView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelComicsView()
    }
}
