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
    
    let loginViewController = LoginViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame:  UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        window?.rootViewController = loginViewController
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate{
    func didLogin() {
        print("foo - didlogin")
    }  
}

