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
    let title: String
    
    static func makeSkeleton() -> Product{
        return Product(title: "Test")
    }
}


extension TestViewController{
    func fetchProducts(completion: @escaping(Result<[Product],ErrorNetworkProducts>) -> Void){
        let url = URL(string: "https://fakestoreapi.com/products")!
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

