//
//  NetworkManager.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import Foundation

final class NetworkManager {
    
    func getCards(from url: URL, offset: Int? = nil, handler: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        let jsonBody = try? JSONSerialization.data(
            withJSONObject: ["offset": offset ?? 0]
        )
        let header = Header.requestHeader
        
        request.httpMethod = "POST"
        request.httpBody = jsonBody
        request.setValue(header.value, forHTTPHeaderField: header.key)
                
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data {
                handler(.success(data))
            }
            
            if let error = error {
                handler(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode != 200 {
                switch response.statusCode {
                case 400:
                    handler(.failure(NetworkError.badRequest))
                case 401:
                    handler(.failure(NetworkError.authError))
                case 500:
                    handler(.failure(NetworkError.internalServerError))
                default:
                    break
                }
            }
        }
        )
        task.resume()
    }
}
