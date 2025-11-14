//
//  ViewController.swift
//  WeatherNotes
//
//  Created by mac on 13.11.2025.
//

import UIKit

class NotesListViewController: UITableViewController {
    private var notes: [Note] = NoteMocks.sampleNotes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Weather-Notes"
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        setupAddButton()
        
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
        tableView.rowHeight = 60
    }
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(addNote)
        )
    }
    
    @objc private func addNote() {
        // пізніше тут буде перехід на AddNoteViewController
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
        
        let selectedNote = notes[indexPath.row]   // mock-дані
        let detailVC = NoteDetailViewController(note: selectedNote)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

