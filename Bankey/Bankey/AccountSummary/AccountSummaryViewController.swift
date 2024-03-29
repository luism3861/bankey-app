//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 09/09/22.
//

import UIKit

class AccountSummaryViewController: UIViewController{
    //Request Models
    var profile: Profile?
    var accounts: [Account] = []
    
    //View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    //Components
    var tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "", message: "",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default, handler: nil))
        return alert
    }()
    
    //Networking
    var profileManager: ProfileManageable = ProfileManager()
    
    var isLoaded = false
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout",style: .plain,target:  self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
}

extension AccountSummaryViewController{
    private func setup(){
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
    }
}


extension AccountSummaryViewController{
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    private func setupTableHeaderView(){
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeletons(){
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 100)
        configureTableAccountCells(with: accounts)
    }
}


extension AccountSummaryViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        
        if isLoaded{
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.selectionStyle = .none
            cell.configure(with: accountCellViewModels[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ProductsViewController(), animated: true)
    }
}


extension AccountSummaryViewController {
    private func fetchData() {
        let group = DispatchGroup()
        
        let userId = String(Int.random(in: 1..<4))
        
        fetchProfile(group,userId)
        fetchAccounts(group,userId)
        
        group.notify(queue: .main){
            self.reloadView()
        }
    }
    
    private func fetchProfile(_ group: DispatchGroup,_ userId: String){
        group.enter()
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
    private func fetchAccounts(_ group: DispatchGroup,_ userId: String){
        group.enter()
        fetchAccounts(userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
    
    private func reloadView(){
        self.tableView.refreshControl?.endRefreshing()
        
        guard let profile = self.profile else { return }
        
        self.isLoaded = true
        self.configureTableProfileHeaderView(with: profile)
        self.configureTableAccountCells(with: self.accounts)
        self.tableView.reloadData()
    }
    
    private func configureTableProfileHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configureAccountViewModel(with: vm)
    }
    
    
    private func configureTableAccountCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type,
                                         accountName: $0.name,
                                         balance: $0.amount)
        }
    }
    
    private func showErrorAlert(_ title: String,_ message: String){
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert,animated: true, completion: nil)
    }
    
    private func displayError(_ error:  NetworkError){
        let titleAndMessage = titleAndMessage(error)
        self.showErrorAlert(titleAndMessage.0, titleAndMessage.1)
    }
    
    private func titleAndMessage(_ error: NetworkError) -> (String, String){
        let title: String
        let message: String
        switch error{
        case .serverError:
            title = "Server Error"
            message = "We could not process your request. Please try again."
        case .decodingError:
            title = "Network Error"
            message = "Ensure you are connected to the internet. Please try again."
        }
        return (title,message)
    }
}

extension AccountSummaryViewController{
    @objc func logoutTapped(sender: UIButton){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    @objc func refreshContent(){
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    private func reset(){
        profile = nil
        accounts = []
        isLoaded = false
    }
}


extension AccountSummaryViewController{
    func titleAndMessageForTesting(_ error: NetworkError) -> (String,String){
        return titleAndMessage(error)
    }
    
    func forceFetchProfile(){
        fetchProfile(DispatchGroup(),"1")
    }
}
