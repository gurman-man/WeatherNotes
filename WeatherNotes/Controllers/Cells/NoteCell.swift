//
//  NoteCell.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import UIKit

class NoteCell: UITableViewCell {
    static let identifier = "NoteCell"
    
    private let noteLabel = UILabel()
    private let dateLabel = UILabel()
    private let tempLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        // Налаштуванння шрифтів
        noteLabel.font = .systemFont(ofSize: 18, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 13, weight: .light)
        tempLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        // Іконка погоди
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        
        let stack = UIStackView(arrangedSubviews: [noteLabel, dateLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 2
        
        contentView.addSubview(stack)
        contentView.addSubview(tempLabel)
        contentView.addSubview(iconImageView)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Contraints
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            iconImageView.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -8),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    // Отримуємо Note і заповнюємо UI
    func configure(with note: Note) {
        // Текст нотатки
        noteLabel.text = note.text
        
        // Форматована дата + час створення
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:mm"
        dateLabel.text = formatter.string(from: note.date)
        
        // Температура, якщо вона є
        tempLabel.text = note.temperature != nil ? "\(note.temperature!)°C" : ""
        
        // Якщо є код іконки — завантажуємо з сервера
        if let iconCode = note.weatherIcon {
            let urlString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
            
            if let url = URL(string: urlString) {
                
                // Завантажуємо іконку асинхронно
                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let self = self else { return }
                    
                    // Якщо отримали дані — конвертуємо в зображення
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.iconImageView.image = image
                        }
                    } else {
                        // Якщо завантаження не вдалося — показуємо пусто або placeholder
                        DispatchQueue.main.async {
                            self.iconImageView.image = nil // або placeholder
                        }
                    }
                    
                }.resume()
            }
        } else {
            // Якщо іконки немає — очищуємо поле
            iconImageView.image = nil
        }
    }
}
