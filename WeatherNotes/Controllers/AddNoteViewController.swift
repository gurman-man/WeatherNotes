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
        
        weatherService.fetchWeather(for: "Ternopil") { result in
            switch result {
            case .success(let weather):
                let newNote = Note(
                    id: UUID(),
                    text: text,
                    date: Date(),
                    temperature: weather.temperature,
                    weatherIcon: weather.icon
                )
                
                DispatchQueue.main.async {
                    self.onSave?(newNote) // Передаємо нову нотатку назад у список
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            case .failure:
                let ac = UIAlertController(title: "❌", message: "Failed to fetch weather!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                
                DispatchQueue.main.async {
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
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}
