//
//  ViewController.swift
//  Names to Faces
//
//  Created by Tomás Santiago on 03/05/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]() //Guarda dados de todas as pessoas na aplicação.
    
    //UIImagePickerControllerDelegate diz-nos quando o utilizador escolhe uma imagem ou cancela o picker.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            
            let jsonDecoder = JSONDecoder()
            
            // [Person].self = Attemp to create an array of person from Data.
            do {
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            }
            catch {
                print("Failed to load people.")
            }
        }
    }
    
    //Estes dois métodos funcionam praticamente da mesma forma em relação ao que tinhamos na Table View.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return people.count //Nº de pessoas no nosso people array.
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            
            fatalError("Unable to dequeue cell.")
        }
        
        let person = people[indexPath.item]
        cell.name.text = person.name //.name é o nosso UILabel.
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    @objc func addNewPerson() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true //Permite ao utilizador editar a fotografia escolhida.
        picker.delegate = self //Podemos responder a mensagens do picker.
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        //Lê o diretório de documentos para a aplicação.
        
        //Converter a imagem para JPEG
        if let JPEGData = image.jpegData(compressionQuality: 0.8) {
            try? JPEGData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    //Este diretório pode estar em qualquer lado na árvore de ficheiros.
    //Apple diz-nos onde está este diretório.
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0] //Normalmente é um diretório que contem apenas uma coisa.
        
        //Primeiro parâmetro (.documentDirectory) pede o diretório de documentos.
        //Segundo parâmetro: Queremos esse diretório para o utilizador atual.
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let person = people[indexPath.item]
        
        let alertController = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) {
            
            [weak self, weak alertController] _ in
                
            guard let newName = alertController?.textFields?[0].text else {
                return
            }
        
            person.name = newName
            self?.save()
            
            self?.collectionView.reloadData()
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    func save() {
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(people) {
            
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
        else {
            
            print("Failed to save.")
        }
    }
}

