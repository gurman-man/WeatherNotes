//
//  Note.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import Foundation

struct Note: Codable {
    let id: UUID
    let text: String
    let date: Date
    let temperature: Double?
    let weatherIcon: String?
}
