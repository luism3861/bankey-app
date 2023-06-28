//
//  SettingsViewControlller.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 17/05/23.
//

import UIKit

class SettingsViewController: UITableViewController{
    private var viewModel: SettingsViewModel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .secondarySystemBackground
        viewModel = SettingsViewModel(delegate: self)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}


extension SettingsViewController: SettingsViewModelDelegate{
    func twitterCellTapped(){
        if let url = URL(string: "https://twitter.com/luism3861"){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func facebookCellTapped(){
        if let url = URL(string: "https://fb.com/luism3861"){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
