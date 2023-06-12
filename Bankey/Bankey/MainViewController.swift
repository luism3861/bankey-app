//
//  MainViewController.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 26/08/22.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let cameraVC = CameraViewController()
        let productVC = ProductsViewController()
        let settingVC = SettingsViewController()
        
        summaryVC.setTabBarImage("list.dash.header.rectangle", "Summary")
        cameraVC.setTabBarImage("camera", "Camera")
        productVC.setTabBarImage("ellipsis.circle", "More")
        settingVC.setTabBarImage("gear", "Settings")
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let cameraNC = UINavigationController(rootViewController: cameraVC)
        let productNC = UINavigationController(rootViewController: productVC)
        let settingNC = UINavigationController(rootViewController: settingVC)
        
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, cameraNC, productNC, settingNC]
        
        viewControllers = tabBarList
    }
    //this hide header for navigation controller by default
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}



