//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Tomás Santiago on 11/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        //Constante que nos permite trabalhar com o File System
        
        let path = Bundle.main.resourcePath!
        //Bundle é o diretório que contem o programa compilado e todos os ficheiros auxiliares.
        
        let itemsInDir = try! fileManager.contentsOfDirectory(atPath: path)
        //Direciona para o conteúdo presente no diretório path definido acima.
        
        for item in itemsInDir {
            if(item.hasPrefix("nssl")) {
                //This a picture to load
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            viewController.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

