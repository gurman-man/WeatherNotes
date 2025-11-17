//
//  NotesStorage.swift
//  WeatherNotes
//
//  Created by mac on 15.11.2025.
//

import Foundation

struct NotesStorage {
    private static let key = "savedNotes"
    
    // MARK: - Synchronous
    static func saveNotes(_ notes: [Note]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(notes) // перетворюємо notes у JSON
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save notes:", error.localizedDescription)
        }
    }
    
    
    static func loadNotes() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return [] // якщо даних немає, повертаємо пустий масив
        }
        
        
        let decoder = JSONDecoder()
        do {
            let notes = try decoder.decode([Note].self, from: data) // перетворюємо JSON у структуру Note
            return notes
        }catch {
            print("Failed to load notes:", error.localizedDescription)
            return []
        }
    }
    
    // MARK: - Asynchronous
    static func saveNotesAsync(_ notes: [Note]) {
        DispatchQueue.global(qos: .utility).async {
            saveNotes(notes)
        }
    }
    
    static func loadNotesAsync(completion: @escaping ([Note]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let notes = loadNotes()
            DispatchQueue.main.async {
                completion(notes)
            }
        }
    }
}
