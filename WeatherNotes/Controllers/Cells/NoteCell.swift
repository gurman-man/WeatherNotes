//
//  NoteCell.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import UIKit

class NoteCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "NoteCell"
    
    // MARK: - UI Elements
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup UI
    private func setupUI() {
        // Stack для тексту нотатки та дати
        let stack = UIStackView(arrangedSubviews: [noteLabel, dateLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 2
        
        // Додаємо subviews
        contentView.addSubview(stack)
        contentView.addSubview(tempLabel)
        contentView.addSubview(iconImageView)
        
        // Вимикаємо autoresizing mask
        [stack, tempLabel, iconImageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        
        // MARK: - Constraints
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
    
    
    // MARK: - Configure Cell
    func configure(with note: Note) {
        // Текст нотатки
        noteLabel.text = note.text
        
        // Форматована дата + час створення
        dateLabel.text = note.date.formatted()
        
        // Температура, якщо вона є
        tempLabel.text = note.temperature != nil ? "\(note.temperature!)°C" : ""
        
        // Якщо є код іконки — завантажуємо з сервера
        iconImageView.setWeatherIcon(note.weatherIcon ?? "")
    }
}
