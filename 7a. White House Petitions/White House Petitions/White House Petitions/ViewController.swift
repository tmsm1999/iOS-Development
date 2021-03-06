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
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsButtonTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        
        let petitionURLString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            petitionURLString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        else {
            petitionURLString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        if let url = URL(string: petitionURLString) {
            if let data = try? Data(contentsOf: url) {
                //É seguro fazer parsing dos dados mas como pode dar erro usamos try?
                parseData(json: data)
                return
            }
        }
        
        showError()
    }
    
    @objc func creditsButtonTapped() {
        
        let alertView = UIAlertController(title: "Credits", message: "The data shown in this app comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    @objc func filterButtonTapped() {
        
        let alertView = UIAlertController(title: "Enter an expression", message: nil, preferredStyle: .alert)
        alertView.addTextField()
        
        let applyFilterAction = UIAlertAction(title: "Apply filter", style: .default) {
            
            [weak self, weak alertView] action in
                guard let word = alertView?.textFields?[0].text else {
                    return
                }
                    
                if word.count > 0 {
                    self?.searchPetitions(word: word)
                }
                else {
                    self?.filteredPetitions.removeAll(keepingCapacity: true)
                    self?.tableView.reloadData()
                }
        }
        
        let clearFilterAction = UIAlertAction(title: "Clear filter", style: .default, handler: clearFilterTapped)
        
        alertView.addAction(applyFilterAction)
        alertView.addAction(clearFilterAction)
        
        present(alertView, animated: true, completion: nil)
    }
    
    func searchPetitions(word: String) {

        filteredPetitions.removeAll(keepingCapacity: true)
        
        for petition in petitions {
            
            let wordsArray: [String] = petition.body.lowercased().components(separatedBy: " ")
            
            if wordsArray.contains(word.lowercased()) {
                filteredPetitions.append(petition)
            }
        }
        
        if filteredPetitions.isEmpty {
            
            let alertView = UIAlertController(title: "Error!", message: "Could not find any petition with that expression.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            present(alertView, animated: true)
            
            return
        }
        
        tableView.reloadData()
    }
    
    func clearFilterTapped(action :UIAlertAction!) {
        
        filteredPetitions.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    //Data é qualquer tipo de dados binários. É um tipo de dados que vem da Foundation framework.
    func parseData(json: Data) {
        
        let decoderObject = JSONDecoder()
        
        if let jsonPetitions = try? decoderObject.decode(PetitionsArray.self, from: json) {
            
            petitions = jsonPetitions.results
            tableView.reloadData()
            return
        }
        
        showError()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredPetitions.isEmpty {
            return filteredPetitions.count
        }
        
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        
        if !filteredPetitions.isEmpty && indexPath.row < filteredPetitions.count {
            newCell.textLabel?.text = filteredPetitions[indexPath.row].title
            newCell.detailTextLabel?.text = filteredPetitions[indexPath.row].body
            return newCell
        }
        
        newCell.textLabel?.text = petitions[indexPath.row].title
        newCell.detailTextLabel?.text = petitions[indexPath.row].body

        return newCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = self.storyboard?.instantiateViewController(identifier: "PetitionDetails") as! PetitionDetailsViewController
        
        //Passa a petição que queremos mostrar para o PetitionViewController.
        if !filteredPetitions.isEmpty {
            viewController.item = filteredPetitions[indexPath.row]
        }
        else {
            viewController.item = petitions[indexPath.row]
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError() {
        
        let alertViewController = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed. Please check your connection and try again.", preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        present(alertViewController, animated: true, completion: nil)
    }
}

//For this app your challenge is:

//1 - Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.

//2 - Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck.

//3 - Experiment with the HTML – this isn’t a HTML or CSS tutorial, but you can find lots of resources online to give you enough knowledge to tinker with the layout a little.
