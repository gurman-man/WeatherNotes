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

    private let textField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter note..."
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Add Note"
        
        view.addSubview(textField)
        view.addSubview(activityIndicator)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,  // стандартна іконка "Save"
            target: self,
            action: #selector(saveTapped)
        )
        
        setupConstraints()
    }
    
    @objc func saveTapped() {
        let text = textField.text ?? ""
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
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            activityIndicator.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 100),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
