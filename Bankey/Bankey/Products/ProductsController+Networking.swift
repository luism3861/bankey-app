//
//  File.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 11/03/23.
//

import UIKit
import Foundation


enum ErrorNetworkProducts: Error{
    case serverError
    case decodingError
}

struct Product: Codable{
    let name: String
    
    static func makeSkeleton() -> Product{
        return Product(name: "Test")
    }
}


extension ProductsViewController{
    func fetchProducts(completion: @escaping(Result<[Product],ErrorNetworkProducts>) -> Void){
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        URLSession.shared.dataTask(with: url){data, response , error in
            DispatchQueue.main.async{
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else
                {
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let products = try decoder.decode([Product].self, from: data)
                    completion(.success(products))
                }catch{
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

