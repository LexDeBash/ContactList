//
//  DetailContactViewController.swift
//  ContactList
//
//  Created by Alexey Efimov on 16.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class DetailContactViewController: UIViewController {
    
    @IBOutlet var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.frame.height / 2
        }
    }
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    
    var result: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues(with: result)
    }
    
    private func setValues(with result: User) {
        if let imageURL = result.picture?.large {
            ImageManager.shared.getUserImage(from: imageURL) { imageData in
                self.userImageView.image = UIImage(data: imageData)
            }
        }
        
        firstNameLabel.text = result.name?.first
        lastNameLabel.text = result.name?.last
    }
}
