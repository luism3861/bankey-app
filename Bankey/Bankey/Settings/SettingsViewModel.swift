//
//  SettingsViewModel.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 27/05/23.
//

import UIKit


protocol SettingsViewModelDelegate: AnyObject{
    func twitterCellTapped()
    func facebookCellTapped()
}


class SettingsViewModel: NSObject{
    static let reuseIdentifier = "SettingsCell"
    private weak var delegate: SettingsViewModelDelegate?
    private var tableViewSections = [SettingsSection]()
    
    init(delegate: SettingsViewModelDelegate) {
        super.init()
        self.delegate = delegate
        configureDataSource()
    }
    
    private func configureDataSource(){
        let getInTouchSection = SettingsSection(
           title: "Get in touch",
           cells: [
              SettingsItem(
                createdCell: {
                    let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.reuseIdentifier)
                    cell.textLabel?.text = "Twitter"
                    cell.accessoryType = .disclosureIndicator
                    return cell
                },
                action: { [weak self] _ in self?.delegate?.twitterCellTapped() }
              ),
              SettingsItem(
                createdCell: {
                    let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.reuseIdentifier)
                    cell.textLabel?.text = "Facebook"
                    cell.accessoryType = .disclosureIndicator
                    return cell
                },
                action: { [weak self] _ in self?.delegate?.facebookCellTapped() }
              ),
           ]
           
        )
        tableViewSections = [getInTouchSection]
    }
}


extension SettingsViewModel: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        return cell.createdCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        cell.action?(cell)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSections[section].title
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView{
            headerView.textLabel?.text = tableViewSections[section].title
            headerView.textLabel?.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize, weight: .bold)
            headerView.backgroundColor = UIColor.red
        }
    }
}
