//
//  ViewController.swift
//  WeatherNotes
//
//  Created by mac on 13.11.2025.
//

import UIKit

class NotesListViewController: UITableViewController {
    private var notes: [Note] = []
    private var weatherService = WeatherService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Weather-Notes"
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupAddButton()
        
        // Асинхронне завантаження нотаток
        NotesStorage.loadNotesAsync { [weak self] loadedNotes in
            guard let self = self else { return }
            self.notes = loadedNotes
            self.tableView.reloadData()
        }
        
        // Асинхронне отримання погоди
        weatherService.fetchWeather(for: "Ternopil") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    print(weather)
                    
                case .failure(let error):
                    print("❌", error.localizedDescription)
                }
            }
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .separator
        tableView.rowHeight = 80
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
    }
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(addNote)
        )
    }
    
    @objc private func addNote() {
        let addVC = AddNoteViewController()
        
        addVC.onSave = { [weak self] note in
            guard let self = self else { return }
            
            notes.append(note)
            tableView.reloadData()
            NotesStorage.saveNotesAsync(self.notes)  // Асинхронне збереження
        }
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    
    // MARK: - Table View data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteCell.identifier,
            for: indexPath
        ) as? NoteCell else { return UITableViewCell() }
        
        cell.configure(with: notes[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedNote = notes[indexPath.row]
        let detailVC = NoteDetailViewController(note: selectedNote)

        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            NotesStorage.saveNotesAsync(notes)  // Асинхронне збереження після видалення
        }
    }
}

