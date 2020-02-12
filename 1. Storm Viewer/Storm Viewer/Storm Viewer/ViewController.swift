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
}

//For this project, your challenges are:

//1 - Use Interface Builder to select the text label inside your table view cell and adjust its font size to something larger – experiment and see what looks good. -- DONE

//2 - In your main table view, show the image names in sorted order, so “nssl0033.jpg” comes before “nssl0034.jpg”. -- DONE

//3 - Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0. --DONE
 
