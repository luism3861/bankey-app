//
//  AppDelegate.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 05/05/22.
//


import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame:  UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        registerForNotification()
        displayNextScreen()
        return true
    }
    
    private func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
    private func displayNextScreen(){
        if LocalState.hasOnboarded{
            setRootViewController(loginViewController)
        }else{
            setRootViewController(onboardingContainerViewController)
        }
    }
    
}


extension AppDelegate{
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        let navigationController = UINavigationController(rootViewController: vc)

        guard animated, let window = self.window else {
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            return
        }
        
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}


extension AppDelegate: LoginViewControllerDelegate{
    func didLogin() {
      
       
        setRootViewController(mainViewController)
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate{
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(loginViewController)
    }
}


extension AppDelegate: LogoutDelegate{
    @objc func didLogout() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = .systemBackground

        setRootViewController(loginViewController)
    }
}
