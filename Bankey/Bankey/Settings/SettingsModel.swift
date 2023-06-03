//
//  SettingsModel.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 27/05/23.
//

import UIKit


struct SettingsSection{
    var title: String
    var cells: [SettingsItem]
}


struct SettingsItem{
    var createdCell: () -> UITableViewCell
    var action: ((SettingsItem) -> Swift.Void)?
}






