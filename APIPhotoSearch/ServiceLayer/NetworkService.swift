//
//  NetworkService.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 22.06.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func fetchPhotos(query: String, completion: @escaping (Swift.Result<APIResponse?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func fetchPhotos(query: String, completion: @escaping (Swift.Result<APIResponse?, Error>) -> Void) {
        
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=21&query=\(query)&client_id=zizJcT9Yvo6kEFuZchG01OoNL9ker2joCcXi1pyQ-bw"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                print(String(describing: error))
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data!)
                completion(.success(jsonResult))
            }
            catch {
                completion(.failure(error))
                print(String(describing: error))
            }
        }
        task.resume()
    }
}


