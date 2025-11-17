//
//  WeatherResponse.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let weather: [WeatherInfo]
    let main: TempInfo
    let wind: WindInfo
    let clouds: CloudsInfo
}

struct WeatherInfo: Decodable {
    let description: String
    let icon: String
}

struct TempInfo: Decodable {
    let temp: Double
    let humidity: Int
}

struct WindInfo: Decodable {
    let speed: Double
}

struct CloudsInfo: Decodable {
    let all: Int
}
