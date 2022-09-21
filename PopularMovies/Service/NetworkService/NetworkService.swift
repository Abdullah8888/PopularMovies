//
//  NetworkService.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
struct ErrorModel: Codable, Error {
    let message: String?
}

protocol RemoteServiceProtocol {
    func fetch<T>(pathUrl: String, type: T.Type, completionHandler completion: @escaping (Result<T, ErrorModel>) -> Void) where T: Codable
}

class RemoteService: RemoteServiceProtocol {
    
    func fetch<T>(pathUrl: String, type: T.Type, completionHandler completion: @escaping (Result<T, ErrorModel>) -> Void) where T: Codable{
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
            URLQueryItem(name: "language", value: "en-US")]

        guard let urlComponents = URLComponents(string: AppConfiguration.baseUrl+pathUrl) else {
            return
        }
        var urlComps = urlComponents
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard error == nil else {
                completion(.failure(ErrorModel(message: error?.localizedDescription ?? "")))
                return
            }
            guard let data = data else {
                completion(.failure(ErrorModel(message: "Unable to retrive data")))
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(type.self, from: data) {
                completion(.success(decodedResponse))
            }
            else {
                completion(.failure(ErrorModel(message: "Unable to decode data")))
            }
            
        }.resume()
        
    }
    
}
