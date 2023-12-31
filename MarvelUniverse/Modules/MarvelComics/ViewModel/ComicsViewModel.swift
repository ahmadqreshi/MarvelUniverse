//
//  ComicsViewModel.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation

class ComicsViewModel: ObservableObject {
    
    private let dataRepo: ComicsDataServiceProtocol
    @Published private(set) var comics: [ComicsModel] = [] // main source for data population
    @Published private(set) var isLoading: Bool = false // used to shoe loader view until data loads
    @Published private(set) var offset: Int = 0 // used to implement the pagiantion
    @Published private(set) var isMoreDataAvailable: Bool = false // used to check whether more data available to load
    @Published var selectedFilter = FilterOptions.releaseThisMonth // variable attached to picker
    
    private var isViewLoaded: Bool = false
    
    init(dataRepo: ComicsDataServiceProtocol = ComicsDataRepository()) {
        self.dataRepo = dataRepo
    }
    
    //MARK: - called on onAppear
    func getData() {
        if !isViewLoaded {
            fetchComicsData()
            isViewLoaded = true
        }
    }
    
    //MARK: - Condition to load more Data
    func shouldLoadData(id: Int, limit: Int)  {
        if id == limit - 1 {
            offset += 1
            fetchComicsData()
        }
    }
    
    func filterChanged() {
        isLoading = true
        comics.removeAll()
        fetchComicsData()
    }
    
    
    private func fetchComicsData() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.offset == 0 {
                strongSelf.isLoading = true
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.dataRepo.getComics(dateDescriptor: strongSelf.selectedFilter.dateDescriptor, offset: strongSelf.offset) { response in
                DispatchQueue.main.async {
                    if strongSelf.comics.isEmpty { // add checks to support pagination
                        strongSelf.comics = response.data.results
                    } else {
                        strongSelf.comics.append(contentsOf: response.data.results)
                    }
                    strongSelf.isLoading = false
                    strongSelf.isMoreDataAvailable = !strongSelf.comics.isEmpty
                }
            } failure: { error in
                debugPrint(error)
            }
        }
    }
}
