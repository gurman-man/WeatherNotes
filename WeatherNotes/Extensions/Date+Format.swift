//
//  Date+Format.swift
//  WeatherNotes
//
//  Created by mac on 16.11.2025.
//

import Foundation

extension Date {
    // Форматована дата + час
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:mm"
        return formatter.string(from: self)
    }
}
