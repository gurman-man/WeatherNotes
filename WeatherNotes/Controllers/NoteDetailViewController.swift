//
//  NoteDetailViewController.swift
//  WeatherNotes
//
//  Created by mac on 14.11.2025.
//

import UIKit

class NoteDetailViewController: UIViewController {

    private let note: Note
    
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
    }

}
