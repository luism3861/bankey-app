//
//  AccountSummaryHeaderView+Networking.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 16/12/22.
//

import Foundation


struct Account: Codable{
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account{
        return Account(id: "1", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: Date())
    }
}




extension AccountSummaryViewController{
    func fetchAccounts(_ userId: String, completion: @escaping(Result<[Account],NetworkError>) -> Void ){
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts")!
        URLSession.shared.dataTask(with: url){data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let accounts = try decoder.decode([Account].self, from: data)
                    completion(.success(accounts))
                } catch {
                    switch response.statusCode{
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.decodingError))
                    }
                }
            }
        }.resume()
    }
}
