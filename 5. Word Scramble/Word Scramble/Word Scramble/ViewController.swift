//
//  ViewController.swift
//  Word Scramble
//
//  Created by Tomás Santiago on 16/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//Insert

import UIKit

class ViewController: UITableViewController {
    
    //Mudei a subclasse para UITableViewController. Depois fui ao Main.storyboard e eliminei a view que lá estava completamente.
    //Depois de estar em branco adicionei um novo elemento UITableViewController. Fui ao identity inspector e mudei a classe para ViewController, o que já se encontrava no documento.
    //Depois no menu lateral da view carreguei em Table View Cell, fui ao inspetor de atributos e mudei o identificador para Word e o style para basic.
    //Finalmente, selecionei o View Controller todo e fui a Editor -> Embed in -> Navigation View Controller.
    
    //Adicionei o ficheiro start.txt à pasta do projeto por baixo de info.plist.
    
    var allWords = [String]() //Todas as palavras presentes no ficheiro de input.
    var usedWords = [String]() //Palavras usadas pelo jogador durante o jogo.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        //if let permite verificar se o bundle.main.url não é nil.
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement() //Palavra que o jogador tem que usar para encontrar sub-palavras.
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Adiciona uma nova célula à tabela através da reutilização de uma célula antiga.
        let newCell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        //indexPath representa a linha e a secção de uma dada célula.
        
        //Adiciona o texto à célula.
        newCell.textLabel?.text = usedWords[indexPath.row]
        
        return newCell
    }
    
    //Como o utilizador vai adicionar uma nova palavra.
    @objc func promptForAnswer() {
        
        let alertView = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        
        alertView.addTextField() //Adiciona um campo de texto editável ao AlertController.
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            
            [weak self, weak alertView] action in
                guard let answer = alertView?.textFields?[0].text else {
                    return
                }
                self?.submit(answer)
        }
        
        alertView.addAction(submitAction)
        present(alertView, animated: true)
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        var errorTitle: String
        var errorMessage: String
        
        if(isPossible(word: lowerAnswer) && isOriginal(word: lowerAnswer) && isReal(word: lowerAnswer)) {
            
            usedWords.insert(lowerAnswer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            //.automatic = animação standard para esta modificação.
            
            errorTitle = "Good Job!"
            errorMessage = "Keep it going..."
        }
        else {
            errorTitle = "Invalid Word!"
            errorMessage = "Pay attention to the word above..."
        }
        
        let alertView = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alertView, animated: true)
        
    }
    
    func isPossible(word: String) -> Bool {
        
        guard var originalWord = title?.lowercased() else {
            return false
        }
        
        for letter in word {
            //Verificamos se a letra está presente no título.
            if let position = originalWord.firstIndex(of: letter) {
                originalWord.remove(at: position)
            }
            else {
                return false
            }
        }
        
        return true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        
        let checker = UITextChecker()
        
        //Qual é o intervalo que queremos verificar?
        //Precisamos de fazer assim por causa de backwards compatibility.
        let range = NSRange(location: 0, length: word.utf16.count)
        
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
        //Retorna true quando não existiram erros.
    }

}

//For this project your challenge is:

//1 - Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.

//2 - Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there.

//3 - Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
