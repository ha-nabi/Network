//
//  NewsAPI.swift
//  SwiftApiDemo
//
//  Created by 강치우 on 11/30/23.
//

import SwiftUI

struct Results: Decodable {
    let articles: [Article]
}

struct Article: Decodable, Hashable {
    let title: String
    let url: String
    let urlToImage: String?    // 이미지는 있을 수도 있고 없을 수도 있으니까 옵셔널으로 선언
}

class NewsAPI: ObservableObject {
    static let shared = NewsAPI()
    private init() { }         // 싱글톤 패턴
    @Published var posts = [Article]()
    
    private var apiKey: String? {
        get {
            let keyfilename = "ApiKeys"
            let api_key = "API_KEY"

            // 생성한 .plist 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: keyfilename, ofType: "plist") else {
                fatalError("Couldn't find file '\(keyfilename).plist'")
            }

            // .plist 파일 내용을 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)

            // 딕셔너리에서 키 찾기
            guard let value = plist?.object(forKey: api_key) as? String else {
                fatalError("Couldn't find key '\(api_key)'")
            }

            return value
        }
    }

    func fetchData() {
        guard let apiKey = apiKey else { return }

        let urlString = "https://newsapi.org/v2/everything?q=Apple&from=2023-11-29&sortBy=popularity&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // 정상적으로 값이 오지 않았을 때 처리
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let responseData = try JSONDecoder().decode(Results.self, from: data)
                print(responseData.articles.count)
                DispatchQueue.main.async {
                    self.posts = responseData.articles
                }
            } catch let error {
                print(error.localizedDescription)
            }
            

        }
        task.resume()
    }
}


