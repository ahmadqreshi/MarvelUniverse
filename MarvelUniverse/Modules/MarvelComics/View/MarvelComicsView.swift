//
//  MarvelComicsView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct MarvelComicsView: View {
    
    @State private var selectedSorting = FilterOptions.releaseThisMonth
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top),
    ]
    
    var body: some View {
        VStack {
            navigationView
                .padding(.all, 16)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(0...20, id: \.self) { _ in
                       ComicsCardView()
                            .padding(.bottom, 32)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private var navigationView: some View {
        HStack {
            filterButton
                .opacity(0)
            Spacer()
            Text("Comics")
                .font(.system(size: 24))
                .fontWeight(.medium)
                .foregroundColor(.black)
            Spacer()
            filterButton
        }
    }
    
    
    private var filterButton: some View {
        Menu {
            Picker("Sort", selection: $selectedSorting) {
                ForEach(FilterOptions.allCases) {
                    Text($0.title)
                }
            }
        } label: {
            Text("Add Filter")
                .foregroundColor(.red)
        }
    }
}

struct MarvelComicsView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelComicsView()
    }
}
