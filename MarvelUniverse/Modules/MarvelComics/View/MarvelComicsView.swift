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
    
    @StateObject private var viewModel: ComicsViewModel = ComicsViewModel()
    
    var body: some View {
        VStack {
            navigationView
                .padding(.all, 16)
            ZStack {
                if viewModel.isLoading {
                    LoaderView()
                } else {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns) {
                            ForEach(Array(viewModel.comics.enumerated()), id: \.offset) { index, comic in
                                ComicsCardView(comic: comic)
                                    .onAppear {
                                        viewModel.shouldLoadData(id: index)
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        if viewModel.isMoreDataAvailable {
                            LastRowView()
                        }
                        
                    }
                }
            }
            
        }
        .onChange(of: viewModel.selectedFilter) { _ in
            viewModel.comics.removeAll()
            viewModel.fetchComicsData()
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
            Picker("Sort", selection: $viewModel.selectedFilter) {
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
