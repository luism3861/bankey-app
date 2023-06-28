//
//  TestViewController.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 19/12/22.
//

import UIKit



class ProductsViewController: UIViewController {
    var products: [Product] = []
    var productCellViewModels: [ProductCell.ViewModelProduct] = []
    var tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    var isLoaded = false
    
    
    override func viewDidLoad() {
        setup()
    }
}

extension ProductsViewController{
    private func setup(){
        title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
    }
}


extension ProductsViewController{
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIDProduct)
        tableView.register(SkeletonCellProducts.self, forCellReuseIdentifier: SkeletonCellProducts.reuseID)
        tableView.rowHeight = ProductCell.rowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeletons(){
        let row = Product.makeSkeleton()
        products = Array(repeating: row, count: 100)
        configureTableProductsCells(with: products)
    }
}

extension ProductsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !productCellViewModels.isEmpty else {
            return UITableViewCell()
        }
        if isLoaded{
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIDProduct, for: indexPath) as! ProductCell
            cell.selectionStyle = .none
            cell.configure(with: productCellViewModels[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCellProducts.reuseID, for: indexPath) as! SkeletonCellProducts
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productCellViewModels.count
    }
    
    
}

extension ProductsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(AnotherPage(), animated: true)
    }
}


extension ProductsViewController{
    private func fetchData(){
        
        fetchProducts() { result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                self.displayError(error)
            }
            self.tableView.refreshControl?.endRefreshing()
            self.isLoaded = true
            self.configureTableProductsCells(with: self.products)
            self.tableView.reloadData()
        }
    }
    
    
    private func configureTableProductsCells(with products: [Product]) {
        productCellViewModels = products.map {
            ProductCell.ViewModelProduct(nameComment: $0.name)
        }
    }
    
    private func showErrorAlert(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",  style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func displayError(_ error: ErrorNetworkProducts){
        let title: String
        let message: String
        switch error{
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again."
        case .decodingError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
        }
        self.showErrorAlert(title, message)
    }
    
}


extension ProductsViewController{
    @objc func refreshContent(){
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    private func reset(){
        products = []
        isLoaded = false
    }
}

