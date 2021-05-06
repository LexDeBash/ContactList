//
//  ImageManager.swift
//  ContactList
//
//  Created by Alexey Efimov on 16.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Alamofire

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func getUserImage(from url: String, completion: @escaping (Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let imageData):
                    completion(imageData)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
