//
//  WeatherResponse.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [WeatherInfo]
    let main: TempInfo
}

struct WeatherInfo: Decodable {
    let description: String
    let icon: String
}

struct TempInfo: Decodable {
    let temp: Double
}
