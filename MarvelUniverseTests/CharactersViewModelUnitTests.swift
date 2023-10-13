//
//  MarvelUniverseTests.swift
//  MarvelUniverseTests
//
//  Created by Ahmad Qureshi on 14/10/23.
//

import XCTest
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
    override func setUpWithError() throws {
        viewModel = CharactersViewModel(dataRepo: MockCharactersDataRepository())
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
