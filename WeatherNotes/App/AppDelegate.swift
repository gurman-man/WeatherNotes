//
//  AppDelegate.swift
//  WeatherNotes
//
//  Created by mac on 13.11.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Вікно програми, в якому відображаються всі ViewController-и
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Створюємо UIWindow розміром як екран пристрою
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Створюємо NotesListViewController і обгортаємо його в UINavigationController
        // Це дає можливість переходів між екранами з навігаційним баром
        let navigationController = UINavigationController(rootViewController: NotesListViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

