//
//  MarvelUniverseTests.swift
//  MarvelUniverseTests
//
//  Created by Ahmad Qureshi on 14/10/23.
//

import XCTest
import Combine
@testable import MarvelUniverse


class MockCharactersDataRepository: CharactersDataServiceProtocol {
    func getCharacters(name: String?, offset: Int, success: @escaping (ResponseModel<CharactersModel>) -> Void, failure: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            CommonFunctions.convertJsonFiletoDto(filename: JsonFiles.charactersResponse.fileName) { (response: ResponseModel<CharactersModel>) in
                success(response)
            } failure: { error in
                failure(error)
            }
        }
    }
}

final class CharactersViewModelUnitTests: XCTestCase {
    
    private var viewModel: CharactersViewModel!
    private var cancellables = Set<AnyCancellable>()
    override func setUpWithError() throws {
        viewModel = CharactersViewModel(dataRepo: MockCharactersDataRepository())
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }

    //MARK: - Test: Data Source Availability
    func testCharactersDataSourceBeforeApiCall() throws {
        XCTAssertTrue(viewModel.characters.isEmpty)
    }
    
    //MARK: - Test: Population of Data Source
    func testCharactersDataSourceAfterApiCall() throws {
        let expectation = XCTestExpectation(description: "Should return Characters after 3 seconds")
        viewModel.getData()
        viewModel.$characters
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.characters.count, 0)
    }
    
    //MARK: - Test: Offset value increases on scrolling to Last
    func testOffsetValueShouldIncreaseOnScrolling() {
        let defaultdataLimit: Int = 20
        viewModel.shouldLoadData(id: 19, limit: defaultdataLimit) // should paginate on last cell
        XCTAssertGreaterThan(viewModel.offset, 0)
    }
    
    //MARK: - Test: Medium on Searching should be query
    func testMediumOnSearchQuery() {
        viewModel.searchQuery()
        XCTAssertTrue(viewModel.medium == .query)
    }
    
    //MARK: - Test: Search Query String should not be empty after search query pressed
    func testSearchQueryShouldNotEmptyOnSubmit() {
        viewModel.searchText = "a"
        viewModel.searchQuery()
        XCTAssertTrue(!viewModel.searchText.isEmpty)
    }
    
    //MARK: - Test: search query should add to history
    func testSearchQueryShouldAddIntoHistory() {
        viewModel.searchText = "a"
        viewModel.searchQuery()
        XCTAssertTrue(viewModel.history.contains(viewModel.searchText))
    }
    
    //MARK: - Test: Search Characters results
    func testSearchCharacterByNameResults() {
        viewModel.searchQuery()
        let expectation = XCTestExpectation(description: "Should return Characters after 3 seconds")
        viewModel.$characters
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.characters.count, 0)
    }
    
}
