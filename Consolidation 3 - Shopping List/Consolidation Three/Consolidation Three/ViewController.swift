//
//  ViewController.swift
//  Consolidation Three
//
//  Created by Tomás Santiago on 17/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemsList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemToList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clean list", style: .plain, target: self, action: #selector(cleanShoppingList))
        
        navigationController?.setToolbarHidden(false, animated: true)
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
        
        toolbarItems = [shareButton]
        
        //toolBar.items = [shareButton]
    }
    
    @objc func addItemToList() {
        
        let alertView = UIAlertController(title: "Insert new item", message: nil, preferredStyle: .alert)
        
        alertView.addTextField(configurationHandler: nil)
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let submitAnswer = UIAlertAction(title: "Add item", style: .default) {
            
            [weak self, weak alertView] action in
            guard let item = alertView?.textFields?[0].text else {
                    return
                }
            self?.submitItemToList(newItem: item)
        }
        
        alertView.addAction(submitAnswer)
        present(alertView, animated: true)
    }
    
    @objc func cleanShoppingList() {
        itemsList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareShoppingList() {
        
        var stringList: String = ""
        
        if itemsList.isEmpty {
            
            let alertView = UIAlertController(title: "Error!", message: "You can not share an empty shopping list.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alertView, animated: true, completion: nil)
            return
        }
        
        for item in itemsList {
            stringList += (item + "\n")
        }
        
        let shareView = UIActivityViewController(activityItems: [stringList], applicationActivities: [])
        present(shareView, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem", for: indexPath)
        
        newCell.textLabel?.text = itemsList[indexPath.row]
        
        return newCell
    }
    
    func submitItemToList(newItem: String) {
        
        var messageTitle: String
        var messageDescription: String
        
        if isValidItem(item: newItem) {
            itemsList.insert(newItem.capitalized, at: 0)
            messageTitle = "Sucess!"
            messageDescription = "\(newItem.capitalized) was added to your shopping list."
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        else {
            messageTitle = "Error!"
            messageDescription = "A new item must contain letters."
        }
        
        let messageView = UIAlertController(title: messageTitle, message: messageDescription, preferredStyle: .alert)
        messageView.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(messageView, animated: true)
    }
    
    func isValidItem(item: String) -> Bool {
        
        for char in item {
            
            if (char >= "a" && char <= "z") || (char >= "A" && char <= "Z") {
                return true
            }
        }
        
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let webView = storyboard?.instantiateViewController(identifier: "ProductWebPage") as? ProductWebPage {
            
            webView.item = itemsList[indexPath.row]
        navigationController?.pushViewController(webView, animated: true)
        }
    }
}

