//
//  ViewController.swift
//  WeatherNotes
//
//  Created by mac on 13.11.2025.
//

import UIKit

class NotesListViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        view.backgroundColor = .white
        setupAddButton()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = "note 1"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

