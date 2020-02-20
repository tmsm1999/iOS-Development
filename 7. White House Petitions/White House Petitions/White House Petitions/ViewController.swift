//
//  ViewController.swift
//  White House Petitions
//
//  Created by Tomás Santiago on 19/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

//Para este projeto foi necessário foi necessário adicionar o navigation view controller do costume e também utilizar o Tab Bar Controller. Para o colocar na view principal basta selecionar o ecrã da table view e clicar em Embed in -> Tab Bar Controller
//Tive que apagar a view inicial e colocar um table view controller. Alterei este ficheiro e editei o identity inspector para colocar esta classe. Depois alterei também o identificador da table view cell e o seu estilo para subtitle que mostra texto em duas linhas da mesma célula da table view.

//Para editar o item presente na tab bar fui a navigation controller scene e alterei o item em System Item.

//O TAB BAR CONTROLLER GERE UM ARRAY DE VIEW CONTROLLERS!

//Selecionei Navigation Controller Scene, fui a identity inspector e atribuí um ID específico à view, para que possamos depois referenciá-lo a partir de código.

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let petitionURLString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: petitionURLString) {
            if let data = try? Data(contentsOf: url) {
                //É seguro fazer parsing dos dados mas como pode dar erro usamos try?
                parseData(json: data)
            }
        }
    }
    
    //Data é qualquer tipo de dados binários. É um tipo de dados que vem da Foundation framework.
    func parseData(json: Data) {
        
        let decoderObject = JSONDecoder()
        
        if let jsonPetitions = try? decoderObject.decode(PetitionsArray.self, from: json) {
            
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        else {
            print("Saiu com erro!")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        newCell.textLabel?.text = petitions[indexPath.row].title
        newCell.detailTextLabel?.text = petitions[indexPath.row].body
        
        return newCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = self.storyboard!.instantiateViewController(identifier: "PetitionDetails") as! PetitionDetailsViewController
        
        //View Controllers não devem ser inicializados com init(), ou seja, let viewController = PetitionDetailsViewController(). Deste modo, o iOS não conecta os outlets.
        //Para isso precisamos de self.storyboard... como está em cima.
        
        viewController.textLabel = petitions[indexPath.row].body
        navigationController?.pushViewController(viewController, animated: true)
    }
}
