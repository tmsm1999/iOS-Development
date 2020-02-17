//
//  ViewController.swift
//  Consolidation Two
//
//  Created by Tomás Santiago on 16/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags of the World"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let contentDir = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in contentDir {
            
            if item.hasPrefix("flag") {
                flags.append(item)
            }
        }
        
        flags.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newCell = tableView.dequeueReusableCell(withIdentifier: "FlagDetail", for: indexPath)
        newCell.textLabel?.text = flags[indexPath.row]
        
        return newCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let showFlagViewController = storyboard?.instantiateViewController(identifier: "FlagImage") as? showFlagImageViewController {
            
            showFlagViewController.flagImageSelected = flags[indexPath.row]
            navigationController?.pushViewController(showFlagViewController, animated: true)
        }
    }
    
    


}

