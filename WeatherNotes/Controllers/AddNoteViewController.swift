//
//  AddNoteViewController.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    var onSave: ((Note) -> Void)? // виклик, який повідомить NotesListViewController, що створено нову нотатку
    private var weatherService = WeatherService()
    
    private let activityIndicator: UIActivityIndicatorView =  {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        view.textColor = .label
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.separator.cgColor
        view.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.textColor = UIColor.label
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Add Note"
        
        view.addSubview(textView)
        view.addSubview(activityIndicator)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTapped)
        )
        
        setupConstraints()
    }
    
    @objc func saveTapped() {
        let text = textView.text ?? ""
        guard !text.isEmpty else { return }
        activityIndicator.startAnimating()
        
        weatherService.fetchWeather(for: "Ternopil") { result in
            switch result {
            case .success(let weather):
                let newNote = Note(
                    id: UUID(),
                    text: text,
                    date: Date(),
                    temperature: weather.temperature,
                    weatherIcon: weather.icon,
                    weatherDescription: weather.description,
                    humidity: weather.humidity,
                    wind: weather.wind,
                    cloudiness: weather.cloudiness,
                    city: weather.city
                )
                
                DispatchQueue.main.async {
                    self.onSave?(newNote) // Передаємо нову нотатку назад у список
                    self.navigationController?.popViewController(animated: true)
                    self.activityIndicator.stopAnimating()
                }
                
                
            case .failure:
                let ac = UIAlertController(title: "❌", message: "Failed to fetch weather!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.present(ac, animated: true)
                }
            }
        
        }
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            activityIndicator.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 30),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
