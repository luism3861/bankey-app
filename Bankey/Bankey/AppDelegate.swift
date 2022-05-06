//
//  AppDelegate.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 05/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame:  UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .green
        window?.rootViewController = ViewController()
        return true
    }
}

