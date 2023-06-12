//
//  UiViewController+Utils.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 26/08/22.
//

import UIKit


extension UIViewController{
    
    func setTabBarImage(_ imageName: String, _ title: String){
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
     func prepMainViewDisable(){
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
}
