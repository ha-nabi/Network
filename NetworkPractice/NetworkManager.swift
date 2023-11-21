//
//  NetworkManager.swift
//  NetworkPractice
//
//  Created by 강치우 on 11/15/23.
//

import Foundation

enum Networkerror: Error {
    case invalidURL
    case badConnection
    case invalidResponse
    case invalidData
    
    var errorMessage: String {
        switch self {
            
        case .invalidURL:
            return "This is not correct url"
        case .badConnection:
            return "We got some error. check the internet"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "The data recived is worng"
        }
    }
}

//enum MyResult<T> {
//    case sussess(data: T)
//    case failure(error: Networkerror)
//}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func requestUser(completed: @escaping (Result<User, Networkerror>) -> ()) {
        let endPoint = "https://koreanjson.com/users/1"
        
        // url이 맞는지 검증해야함
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.badConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func requestPost(completed: @escaping (Result<Post, Networkerror>) -> ()) {
        let endPoint = "https://koreanjson.com/posts/1"
        
        // url이 맞는지 검증해야함
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.badConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Post.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print(error)
            }
        }.resume()
    }
}
