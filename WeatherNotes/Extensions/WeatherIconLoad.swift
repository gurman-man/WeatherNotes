//
//  ImageView.swift
//  WeatherNotes
//
//  Created by mac on 16.11.2025.
//

import UIKit

extension UIImageView {
    func setWeatherIcon(_ code: String) {
        let urlString = "https://openweathermap.org/img/wn/\(code)@2x.png"
        
        // Якщо є код іконки — завантажуємо з сервера
        guard let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        
        // Завантажуємо іконку асинхронно
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            // Якщо отримали дані — конвертуємо в зображення
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                // Якщо завантаження не вдалося — показуємо пусто або placeholder
                DispatchQueue.main.async {
                    self.image = nil  // або placeholder
                }
            }
            
        }.resume()
    }
}
