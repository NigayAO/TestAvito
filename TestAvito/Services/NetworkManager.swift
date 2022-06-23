//
//  NetworkManager.swift
//  TestAvito
//
//  Created by Alik Nigay on 23.06.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case descriptionError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let stringURL = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    private init() {}
    
    func fetchData(completion: @escaping(Result<MocObject, NetworkError>) -> Void) {
        guard let url = URL(string: stringURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let receivedData = try JSONDecoder().decode(MocObject.self, from: data)
                completion(.success(receivedData))
            } catch {
                completion(.failure(.descriptionError))
            }
            
        }).resume()
    }
}
