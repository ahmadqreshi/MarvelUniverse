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
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var offset: Int = 0
    @Published private(set) var isMoreDataAvailable: Bool = false
    @Published var selectedFilter = FilterOptions.releaseThisMonth
    
    private var isViewLoaded: Bool = false
    
    init(dataRepo: ComicsDataServiceProtocol = ComicsDataRepository()) {
        self.dataRepo = dataRepo
    }
    
    func getData() {
        if !isViewLoaded {
            fetchComicsData()
            isViewLoaded = true
        }
    }
    
    
    func shouldLoadData(id: Int)  {
        if id == comics.count - 1 {
            offset += 1
            fetchComicsData()
        }
    }
    
    func filterChanged() {
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
