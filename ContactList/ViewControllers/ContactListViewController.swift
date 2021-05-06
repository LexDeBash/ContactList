//
//  ContactListViewController.swift
//  ContactList
//
//  Created by Alexey Efimov on 16.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class ContactListViewController: UITableViewController {
        
    private var contacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        downloadData()
        setupRefreshControl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailContactViewController
        detailVC.result = sender as? User
    }
}

// MARK: - UITAbleViewDataSource
extension ContactListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = contacts[indexPath.row]
        content.text = contact.name?.first
        content.secondaryText = contact.name?.last
        
        if let imageURL = contact.picture?.thumbnail {
            ImageManager.shared.getUserImage(from: imageURL) { imageData in
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactListViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = contacts[indexPath.row]
        performSegue(withIdentifier: Segues.showContact.rawValue, sender: currentUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private Methods
extension ContactListViewController {
    private func downloadData() {
        NetworkManager.shared.getUsers { results in
            self.contacts = results
            self.tableView.reloadData()
        }
    }
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(updateView), for: .valueChanged)
    }
    
    @objc private func updateView() {
        NetworkManager.shared.getUsers { results in
            self.contacts = results
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
}

