//
//  NoteDetailViewController.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import UIKit

final class NoteDetailViewController: UIViewController {

    private let note: Note
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
    
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let weatherRowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Details"
        
        view.addSubview(stack)
        
        // Налаштування weatherRowStack
        weatherRowStack.addArrangedSubview(weatherIconView)
        weatherRowStack.addArrangedSubview(tempLabel)
        
        // Налаштування головного stack
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(weatherRowStack)
        stack.addArrangedSubview(weatherDescriptionLabel)
        
        setupConstraints()
        configure(with: note)
    }
    
     func setupConstraints() {
         NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            weatherIconView.widthAnchor.constraint(equalToConstant: 60),
            weatherIconView.heightAnchor.constraint(equalToConstant: 60)
         ])
    }
    
    
    private func configure(with note: Note) {
        titleLabel.text = note.text
        dateLabel.text = note.date.formatted()
        tempLabel.text = note.temperature != nil ? "\(note.temperature!)°C" : ""
        weatherIconView.setWeatherIcon(note.weatherIcon ?? "")
    }

}
