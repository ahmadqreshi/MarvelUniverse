//
//  WebService.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import Foundation
enum ApiError : Error {
    case responseProblem
    case decodingProblem
    case failureMessage(message : String)
}


class WebService {
    
    private init() {}
    static let shared = WebService()
    
    func request<T: Codable>(resultType: T.Type, endpoint: Endpoint, completionHandler: @escaping (Result<T,ApiError>) -> Void) {
        var requestUrl = URLRequest(url: endpoint.url!)
        requestUrl.httpMethod = endpoint.method
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            guard let jsonData = responseData , let urlResponse = httpUrlResponse as? HTTPURLResponse else {
                completionHandler(.failure(.responseProblem))
                return
            }
            if !(200..<300).contains(urlResponse.statusCode) {
                guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { return }
                guard let message = json["message"] as? String else { return }
                completionHandler(.failure(.failureMessage(message: message)))
                return
            }
            debugPrint(jsonData.prettyPrintedJSONString ?? "")
            do {
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                completionHandler(.success(result))
            } catch let error {
                debugPrint("error occured while decoding = \(error.localizedDescription)")
                completionHandler(.failure(.decodingProblem))
            }
        }.resume()
    }
}


extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                       options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                  return nil
               }

        return prettyJSON
    }
}
