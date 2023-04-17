//
//  NetworkManager.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

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
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                handler(.success(data))
            }
            
            if let error = error {
                handler(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse {
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
        task.resume()
    }
    
    func loadImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else { return }

        if let cachedImage = imageFrom(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData),
              error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            completion(image)
            self.saveImageToCache(image: image, url: url, cost: responseData.count)
        }.resume()
    }
    
    private func imageFrom(url: URL) -> UIImage? {
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        return nil
    }
    
    private func saveImageToCache(image: UIImage,url: URL, cost: Int) {
            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString, cost: cost)
    }
}
