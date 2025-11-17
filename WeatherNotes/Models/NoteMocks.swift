//
//  NoteMocks.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import Foundation

struct NoteMocks {
    static let sampleNotes: [Note] = [
        Note(id: UUID(),
             text: "Walking in the park",
             date: Date(),
             temperature: 12.5,
             weatherIcon: "cloud.sun",
             weatherDescription: "cloudy",
             humidity: 72,
             wind: 4.34,
             cloudiness: 100,
             city: "Ternopil"),
        
        Note(id: UUID(),
             text: "Walking in the park",
             date: Date().addingTimeInterval(-86400), // вчора,
             temperature: 18.3,
             weatherIcon: "sun.max",
             weatherDescription: "sunny",
             humidity: 66,
             wind: 5.5,
             cloudiness: 43,
             city: "Ternopil"),
    ]
    
}
