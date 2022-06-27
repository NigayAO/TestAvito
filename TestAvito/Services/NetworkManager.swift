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
        
        let request = URLRequest(url: url)
        
        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 30 * 1024 * 1024)
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.urlCache = cache
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let timer = Timer(timeInterval: 1, repeats: false) { _ in
            cache.removeAllCachedResponses()
            print("Cached was removed")
        }
        
        
        if let data = cache.cachedResponse(for: request)?.data {
            guard let receivedData = try? JSONDecoder().decode(MocObject.self, from: data) else { return }
            print("Data from cached")
            completion(.success(receivedData))
            DispatchQueue.main.asyncAfter(deadline: .now() + 3600) {
                timer.fire()
            }
        } else {
            session.dataTask(with: request) { data, _, _ in
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let receivedData = try JSONDecoder().decode(MocObject.self, from: data)
                    completion(.success(receivedData))
                    print("Data from internet")
                } catch {
                    completion(.failure(.descriptionError))
                }
            }.resume()
        }
    }
}
