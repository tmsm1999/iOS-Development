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
        
        pictures.sort()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTheApp))
    }
    
    //Queremos saber ao certo quantas de quantas linhas vamos precisar.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pictures.count
        //Retornamos o número exato de fotografias que queremos mostrar
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        //vamos reutilizar uma célula que já não se encontra no ecrã.
        //Precisamos do identificador para saber qual é que temos que utilizar.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexPath.row diz qual foi a célula em que carregamos.
        //print(indexPath.row)
        
        //Instanciamos um novo View Controller para mostrar a imagem em que clicamos.
        if let viewController = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            viewController.selectedImage = pictures[indexPath.row]
            viewController.index = indexPath.row + 1
            viewController.totalPics = pictures.count
            
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        //Para colocarmos a Table View dentro de um navigationController clicamos no View Controller de Table Cell e vamos a Editor -> Embed in -> Navigation Controller.
    }
    
    //Isto é uma parte do desafio para este projeto.
    @objc func shareTheApp() {
        
        let viewController = UIActivityViewController(activityItems: ["Hey! I have just installed this app. You should try it too! https://apps.apple.com/us/app/twitter/id333903271"], applicationActivities: [])
        
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(viewController, animated: true)
    }
}

//For this project, your challenges are:

//1 - Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will. -- DONE

//2 - Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people. -- DONE

//3 - Go back to project 2 and add a bar button item that shows their score when tapped. -- DONE
