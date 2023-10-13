//
//  ComicsViewModelUnitTests.swift
//  MarvelUniverseTests
//
//  Created by Ahmad Qureshi on 14/10/23.
//

import XCTest
import Combine
@testable import MarvelUniverse

final class MockComicsDataRepository: ComicsDataServiceProtocol {
    func getComics(dateDescriptor: String?, offset: Int, success: @escaping (ResponseModel<ComicsModel>) -> Void, failure: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            CommonFunctions.convertJsonFiletoDto(filename: JsonFiles.comicsReponse.fileName) { (response: ResponseModel<ComicsModel>) in
                success(response)
            } failure: { error in
                failure(error)
            }
        }
    }
}

final class ComicsViewModelUnitTests: XCTestCase {

    private var viewModel: ComicsViewModel!
    private var cancellables = Set<AnyCancellable>()
    override func setUpWithError() throws {
        viewModel = ComicsViewModel(dataRepo: MockComicsDataRepository())
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }

    //MARK: - Test: Data Source Availability
    func testComicsDataSourceBeforeApiCall() throws {
        XCTAssertTrue(viewModel.comics.isEmpty)
    }
    
    //MARK: - Test: Population of Data Source
    func testComicsDataSourceAfterApiCall() throws {
        let expectation = XCTestExpectation(description: "Should return Characters after 3 seconds")
        viewModel.getData()
        viewModel.$comics
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.comics.count, 0)
    }
    
    //MARK: - Test: Offset value increases on scrolling to Last
    func testOffsetValueShouldIncreaseOnScrolling() {
        let defaultdataLimit: Int = 20
        viewModel.shouldLoadData(id: 19, limit: defaultdataLimit) // should paginate on last cell
        XCTAssertGreaterThan(viewModel.offset, 0)
    }
    
    //MARK: - Test: Date Descriptor Value associated with filters to call api
    func testDateDescriptorValueAssociatedWithFilters() {
        let value1 = "thisWeek"
        let value2 = "lastWeek"
        let value3 = "nextWeek"
        let value4 = "thisMonth"
        
        XCTAssertEqual(value1, FilterOptions.releasedThisWeek.dateDescriptor)
        XCTAssertEqual(value2, FilterOptions.releasedLastWeek.dateDescriptor)
        XCTAssertEqual(value3, FilterOptions.releasingNextWeek.dateDescriptor)
        XCTAssertEqual(value4, FilterOptions.releaseThisMonth.dateDescriptor)
    }
    
    //MARK: - Test: Repopulate data on filter changed
    func testDataSourceOnFilterChange() {
        let expectation = XCTestExpectation(description: "Should return Characters after 3 seconds")
        viewModel.filterChanged()
        XCTAssertTrue(viewModel.comics.isEmpty)
        viewModel.$comics
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.comics.count, 0)
    }
}
