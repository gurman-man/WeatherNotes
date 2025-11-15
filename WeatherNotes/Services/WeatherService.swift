//
//  WeatherService.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import Foundation

enum WeatherError: LocalizedError {
    case invalidURL
    case networkError(String)
    case noData
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:               return "Incorrect server address"
        case .networkError(let msg):    return "Network error: \(msg)"
        case .noData:                   return "The server failed to send the data"
        case .decodingError(let msg):   return "Response processing error: \(msg)"
        }
    }
}

final class WeatherService {
    let apiKey: String = "6675b2d55ddf09a85920e8c1005752ab"
    let url: String = "https://api.openweathermap.org"
    
    func fetchWeather(for city: String, completion: @escaping (Result<Weather, WeatherError>) -> Void) {
        var urlComponents = URLComponents(string: url)
    
        urlComponents?.path = "/data/2.5/weather"
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "ua")
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Cтворюємо об'єкт запиту
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Виконуємо запит
        URLSession.shared.dataTask(with: request) { data, _, err in
            guard err == nil else {
                completion(.failure(.networkError(err!.localizedDescription)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                let weather = Weather(
                    temperature: decoded.main.temp,
                    description: decoded.weather.first?.description ?? "",
                    icon: decoded.weather.first?.icon ?? ""
                )
                completion(.success(weather))
            } catch {
                completion(.failure(.decodingError(err!.localizedDescription)))
            }
            
        }.resume()

    }
}
