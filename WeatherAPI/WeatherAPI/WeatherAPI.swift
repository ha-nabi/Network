//
//  WeatherAPI.swift
//  WeatherAPI
//
//  Created by 강치우 on 12/1/23.
//

import SwiftUI

struct Results: Decodable {
    let weather: [Weather]
}

struct Weather: Decodable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

class WeatherAPI: ObservableObject {
    static let shared = WeatherAPI()
    private init() { }
    @Published var weather = [Weather]()
    
    private var apiKey: String? {
        get {
            let keyfilename = "WeatherApi"
            let APIKEY = "API_KEY"
            
            guard let filePath = Bundle.main.path(forResource: keyfilename, ofType: "plist") else {
                fatalError("Couldn't find file '\(keyfilename)'.plist")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: APIKEY) as? String else {
                fatalError("Couldn't find key '\(APIKEY)'")
            }
            
            return value
        }
    }
    
    func fetchData() {
        
        guard let apiKey = apiKey else { return }

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                // 정상적으로 값이 오지 않았을 때 처리
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let responseData = try JSONDecoder().decode(Results.self, from: data)
                print(responseData.weather.count)
                DispatchQueue.main.async {
                    self.weather = responseData.weather
                }
            } catch let error {
                print(error.localizedDescription)
            }
            

        }
        task.resume()
    }
}
