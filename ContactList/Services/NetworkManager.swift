//
//  NetworkManager.swift
//  ContactList
//
//  Created by Alexey Efimov on 16.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlParams = [
        "results":"\(15)",
    ]
    
    private init() {}
    
    func getUsers(_ completion: @escaping ([User]) -> Void) {
        AF.request(URLConstants.randomUserAPI.rawValue, parameters: urlParams)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let results = User.getRandomUser(from: value) else { return }
                    completion(results)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
