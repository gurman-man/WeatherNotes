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
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 32)
        label.textColor = UIColor.label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-MediumItalic", size: 20)
        label.textColor = UIColor.systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
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
    
    
    private let topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 150
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let middleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cardView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray6
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 12
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private func infoRow(title: String, value: String) -> UIStackView {
        let t = UILabel()
        t.text = title
        t.font = .systemFont(ofSize: 15, weight: .regular)
        t.textColor = .secondaryLabel

        let v = UILabel()
        v.text = value
        v.font = .systemFont(ofSize: 16, weight: .semibold)
        v.textColor = .label

        let stack = UIStackView(arrangedSubviews: [t, UIView(), v])
        stack.axis = .horizontal
        return stack
    }
    
    
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
        
        // Кнопка поділитися
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Додавання стеків
        [topStack, middleStack, cardView, titleLabel].forEach { view.addSubview($0) }
        
        // Додавання полотна
        cardView.addSubview(infoStack)
        
        // Налаштування topStack
        [cityLabel, weatherIconView].forEach { topStack.addArrangedSubview($0) }
        
        // Додавання елементів до middleStack
        [descLabel, tempLabel, dateLabel].forEach { middleStack.addArrangedSubview($0) }

        
        setupConstraints()
        configure(with: note)
    }
    
    
    @objc func shareTapped() {
        var items: [Any] = [note.text]
        if let temp = note.temperature {
            items.append("\(temp)°C in \(note.city ?? "")")
        }
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    
     func setupConstraints() {
         NSLayoutConstraint.activate([
            weatherIconView.widthAnchor.constraint(equalToConstant: 80),
            weatherIconView.heightAnchor.constraint(equalToConstant: 60),
            
            topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            middleStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20),
            middleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            middleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            cardView.topAnchor.constraint(equalTo: middleStack.bottomAnchor, constant: 30),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            infoStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            infoStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            infoStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ])
    }
    
    
    private func configure(with note: Note) {
        titleLabel.text = note.text
        dateLabel.text = note.date.formatted()
        tempLabel.text = note.temperature != nil ? "\(note.temperature!)°C" : ""
        weatherIconView.setWeatherIcon(note.weatherIcon ?? "")
        
        cityLabel.text = note.city
        descLabel.text = note.weatherDescription
        
        infoStack.addArrangedSubview(infoRow(title: "Humidity ", value: "\(note.humidity ?? 0)%"))
        infoStack.addArrangedSubview(infoRow(title: "Wind ", value: "\(note.wind ?? 0)m/s"))
        infoStack.addArrangedSubview(infoRow(title: "Cloudiness ", value: "\(note.cloudiness ?? 0)%"))
    }
}

