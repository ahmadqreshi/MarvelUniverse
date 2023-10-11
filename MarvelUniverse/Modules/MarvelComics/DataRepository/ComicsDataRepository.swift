//
//  ComicsDataRepository.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 11/10/23.
//

import Foundation
class ComicsDataRepository {
    
    private init() {}
    static let shared = ComicsDataRepository()
    
    func getComics(dateDescriptor: String?, offset: Int, success: @escaping (ResponseModel<ComicsModel>) -> Void, failure: @escaping (String) -> Void) {
        WebService.shared.request(resultType: ResponseModel<ComicsModel>.self, endpoint: .comics(dateDescriptor: dateDescriptor, offset: offset)) { response in
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
