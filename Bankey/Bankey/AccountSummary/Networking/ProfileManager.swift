//
//  ProfileManager.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 14/04/23.
//

import Foundation


protocol ProfileManageable: AnyObject{
    func fetchProfile(forUserId userId: String, completion: @escaping(Result<Profile,NetworkError>) -> Void)
}

enum NetworkError: Error{
    case serverError
    case decodingError
}

struct Profile: Codable{
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

class ProfileManager: ProfileManageable{
    func fetchProfile(forUserId userId: String, completion: @escaping(Result<Profile,NetworkError>) -> Void ){
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!
        URLSession.shared.dataTask(with: url){data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil,let response = response as? HTTPURLResponse else {
                    return
                }
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(.success(profile))
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

