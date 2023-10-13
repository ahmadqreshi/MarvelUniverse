//
//  CharactersDataRepository.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation
class CharactersDataRepository {
    
    private init() {}
    static let shared = CharactersDataRepository()
    
    func getCharacters(name: String?, offset: Int, success: @escaping (ResponseModel<CharactersModel>) -> Void, failure: @escaping (String) -> Void) {
        WebService.shared.request(resultType: ResponseModel<CharactersModel>.self, endpoint: .characters(name: name, offset: offset)) { response in
            switch response {
            case .success(let data):
                success(data)
            case .failure(let error):
                switch error {
                case .decodingProblem :
                    failure("response problem")
                case .responseProblem :
                    failure("response problem")
                case .failureMessage(let message) :
                    failure(message)
                }
            }
        }
    }
}
