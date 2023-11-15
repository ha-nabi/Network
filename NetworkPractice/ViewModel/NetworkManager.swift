//
//  NetworkManager.swift
//  NetworkPractice
//
//  Created by 강치우 on 11/15/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func requestUser(completed: @escaping (User?, String?) -> ()) {
        let endPoint = "https://koreanjson.com/users/1"
        
        // url이 맞는지 검증해야함
        guard let url = URL(string: endPoint) else {
            completed(nil, "This is not correct url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "We got some error. check the internet")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data recived is wrong")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                completed(decodedResponse, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func requestPost(completed: @escaping (Post?, String?) -> ()) {
        let endPoint = "https://koreanjson.com/posts/1"
        
        // url이 맞는지 검증해야함
        guard let url = URL(string: endPoint) else {
            completed(nil, "This is not correct url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "We got some error. check the internet")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data recived is wrong")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Post.self, from: data)
                completed(decodedResponse, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}
