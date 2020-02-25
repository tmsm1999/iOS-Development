//
//  ViewController.swift
//  Hangman
//
//  Created by Tomás Santiago on 23/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var clueLabel = UILabel()
    var triesLabel = UILabel()
    var hangmanImage = UIImageView()
    
    var hangmanPictures = [String]()
    
    var wordCategory: String = ""
    var wordLabel = UILabel()
    
    var hiddenButtons = [UIButton]()
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var currentLevel = 1
    
    var numberOfWordsInGame = 0
    
    var currentWordIndex = -1 {
        didSet {
            
            //print(currentWordIndex)
            //print(gameWords.count)
            if currentWordIndex >= gameWords.count || currentWordIndex <= -1 {
                return
            }
            
            var spaces = ""
            
            for _ in 0 ... gameWords[currentWordIndex].count - 1 { //Porque já estou a pôr um underscore em cima e começo a contar em zero
                spaces += "?"
            }
            
            wordLabel.text = spaces
            clueLabel.text = "Word Category: \(wordClue[currentWordIndex])"
            title = "Level \(currentLevel)"
            
        }
    }
    
    var numberOfTriesLeft = 6 {
        didSet {
            
            if numberOfTriesLeft >= 0 {
                hangmanImage.image = UIImage(named: hangmanPictures[numberOfTriesLeft])
                triesLabel.text = "Number of tries left: \(String(numberOfTriesLeft))"
            }
        }
    }
    
    var gameWords = [String]()
    var wordClue = [String]()
    
    var wordToGuess: String = ""
    var totalGuessedWords = 0
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let leftView = UIView()
        leftView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftView)
        
        let rightView = UIView()
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.backgroundColor = .white
        view.addSubview(rightView)
        
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.text = "Level 1"
        clueLabel.font = UIFont(name: "Avenir Next", size: 40)
        clueLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        clueLabel.textAlignment = .center
        view.addSubview(clueLabel)

        hangmanImage.translatesAutoresizingMaskIntoConstraints = false
        hangmanImage.contentMode = .scaleAspectFill
        hangmanImage.image = UIImage(named: "HangPic_6.png")
        view.addSubview(hangmanImage)

        triesLabel.translatesAutoresizingMaskIntoConstraints = false
        triesLabel.text = "Number of tries left: 6"
        triesLabel.font = UIFont(name: "Avenir Next", size: 25)
        triesLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        triesLabel.textAlignment = .center
        view.addSubview(triesLabel)
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.layer.borderWidth = 5
        wordLabel.layer.borderColor = UIColor.black.cgColor
        wordLabel.font = UIFont.systemFont(ofSize: 60)
        wordLabel.textAlignment = .center
        view.addSubview(wordLabel)
        
        
        let firstRowOfButtons = UIView()
        firstRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
        firstRowOfButtons.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(firstRowOfButtons)
        
        let secondRowOfButtons = UIView()
        secondRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
//        secondRowOfButtons.layer.borderColor = UIColor.gray.cgColor
//        secondRowOfButtons.layer.borderWidth = 1
        view.addSubview(secondRowOfButtons)
        
        let thirdRowOfButtons = UIView()
        thirdRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
//        thirdRowOfButtons.layer.borderColor = UIColor.gray.cgColor
//        thirdRowOfButtons.layer.borderWidth = 1
        view.addSubview(thirdRowOfButtons)

        let fourthRowOfButtons = UIView()
        fourthRowOfButtons.translatesAutoresizingMaskIntoConstraints = false
//        fourthRowOfButtons.layer.borderColor = UIColor.gray.cgColor
//        fourthRowOfButtons.layer.borderWidth = 1

        view.addSubview(fourthRowOfButtons)
        
        NSLayoutConstraint.activate([
            
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clueLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            clueLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            hangmanImage.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            hangmanImage.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 230),
            hangmanImage.widthAnchor.constraint(equalToConstant: 400),
            hangmanImage.heightAnchor.constraint(equalToConstant: 400),

            triesLabel.centerXAnchor.constraint(equalTo: hangmanImage.centerXAnchor),
            triesLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            
            wordLabel.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40),
            wordLabel.bottomAnchor.constraint(equalTo: firstRowOfButtons.topAnchor, constant: -90),
            
            leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            leftView.heightAnchor.constraint(equalTo: view.heightAnchor),
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            rightView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            rightView.heightAnchor.constraint(equalTo: view.heightAnchor),
            rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            firstRowOfButtons.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            firstRowOfButtons.bottomAnchor.constraint(equalTo: secondRowOfButtons.topAnchor, constant: -5),
            firstRowOfButtons.heightAnchor.constraint(equalToConstant: 55),
            firstRowOfButtons.widthAnchor.constraint(equalToConstant: 330),

            secondRowOfButtons.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            secondRowOfButtons.bottomAnchor.constraint(equalTo: thirdRowOfButtons.topAnchor, constant: -5),
            secondRowOfButtons.heightAnchor.constraint(equalToConstant: 55),
            secondRowOfButtons.widthAnchor.constraint(equalToConstant: 385),
            
            thirdRowOfButtons.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            thirdRowOfButtons.bottomAnchor.constraint(equalTo: fourthRowOfButtons.topAnchor, constant: -5),
            thirdRowOfButtons.heightAnchor.constraint(equalToConstant: 55),
            thirdRowOfButtons.widthAnchor.constraint(equalToConstant: 330),
            
            fourthRowOfButtons.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            fourthRowOfButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            fourthRowOfButtons.heightAnchor.constraint(equalToConstant: 55),
            fourthRowOfButtons.widthAnchor.constraint(equalToConstant: 385), // 6 * 55
        ])
        
        var letter = 0 //Começamos em alphabet[0]
        let letterRows = [firstRowOfButtons, secondRowOfButtons, thirdRowOfButtons, fourthRowOfButtons]
        let numberOfButtonsPerRow = [6, 7, 6, 7]
        
        let buttonWidth = 55
        let buttonHeight = 55
        
        var index = 0
        
        for row in letterRows {
            
            for place in 0 ... numberOfButtonsPerRow[index] - 1 {
                
                let newButton = UIButton(type: .system)
                newButton.setTitle(String(alphabet[letter]), for: .normal)
                newButton.setTitleColor(UIColor.black, for: .normal)
                
                newButton.addTarget(self, action: #selector(letterButtonPressed), for: .touchUpInside)
                 
                let frame = CGRect(x: place * buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
                newButton.frame = frame
                
                newButton.layer.borderWidth = 1
                newButton.layer.borderColor = UIColor.black.cgColor
                
                row.addSubview(newButton)
                letter += 1
            }
            index += 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Word", style: .plain, target: self, action: #selector(getNewWord))
        
        let FMObject = FileManager.default
        
        if let path = Bundle.main.resourcePath {
            
            let appItems = try! FMObject.contentsOfDirectory(atPath: path)
            
            for item in appItems {
                
                if item.hasPrefix("HangPic") {
                    hangmanPictures.append(item)
                }
            }
            
            hangmanPictures.sort()
            print(hangmanPictures)
        }
        else {
            print("Failed to load Images")
        }
        
        startGame(action: nil)
    }
    
    func startGame(action: UIAlertAction?) {
        
        let file = Bundle.main.url(forResource: "game_words", withExtension: "txt")
        
        gameWords.removeAll(keepingCapacity: true)
        wordClue.removeAll(keepingCapacity: true)
        
        currentLevel = 1
        totalGuessedWords = 0
        
        if let wordsFile = file {
            if let content = try? String(contentsOf: wordsFile) {
                
                var words = content.components(separatedBy: "\n")
                words.shuffle()
                numberOfWordsInGame = words.count
                
                for word in words {
                    
                    let current = word.components(separatedBy: ": ")
                    gameWords.append(current[0])
                    wordClue.append(current[1])
                }
            }
        }
        
        getNewWord(action: nil)
    }
    
    @objc func getNewWord(action: UIAlertAction?) {
        
        currentWordIndex += 1
        
        if currentWordIndex >= gameWords.count {
            
            currentWordIndex = -1
            
            var alertTitle = ""
            var alertMessage = ""
            
            //print(currentLevel)
            if totalGuessedWords == gameWords.count { //Porque sempre que ganhou aumenta 1
                alertTitle = "Game Complete! 🍾"
                alertMessage = "You passed all the levels!"
            }
            else {
                alertTitle = "Out of words! 😢"
                alertMessage = "You did not guess all the words.\nYou finished the game at level \(currentLevel)."
            }
            
            let gameCompleteViewController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            gameCompleteViewController.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: startGame))
            present(gameCompleteViewController, animated: true, completion: nil)
            
            return
        }
        
        for button in hiddenButtons {
            button.isHidden = false
        }
        
        hiddenButtons.removeAll(keepingCapacity: true)
        numberOfTriesLeft = 6
        
        wordToGuess = gameWords[currentWordIndex].uppercased()
    }
    
    @objc func letterButtonPressed(_ sender: UIButton) {
        
        var alertTitle: String = ""
        var alertMessage: String = ""
        var actionTitle: String = ""
        
        let letterPressed = sender.currentTitle?.uppercased()
        
        sender.isHidden = true
        hiddenButtons.append(sender)
        
        if checkLetterInWord(letter: letterPressed) {
            
            if checkVictory() {
                
                totalGuessedWords += 1
                
                if currentLevel < gameWords.count  {
                    
                    alertTitle = "Well done! 🙌"
                    
                    if currentWordIndex < gameWords.count - 1 {
                        alertMessage = "Tap to go to the next level."
                        actionTitle = "Let's go!"
                    }
                    else {
                        alertMessage = "Keep going!"
                        actionTitle = "Continue"
                    }
                    
                    showAlertController(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: actionTitle)
                }
                else {
                    getNewWord(action: nil)
                }
                
                currentLevel += 1
                return
            }
        }
        else {
            numberOfTriesLeft -= 1
        }
        
        if numberOfTriesLeft == 0 {
            alertTitle = "You are Hanged!"
            alertMessage = "The word you had to guess was \(wordToGuess)."
            actionTitle = "Try again"
            showAlertController(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: actionTitle)
        }
    }
    
    func checkLetterInWord(letter: String!) -> Bool {
        
        let wordToGuessChars = Array(wordToGuess)
        
        var letterIsInWord = false
        
        if let currentGuess = wordLabel.text {
            
            var wordLabelChars = Array<Character>(currentGuess)
            
            for (index, char) in wordToGuessChars.enumerated() {
                if String(char) == letter {
                    wordLabelChars[index] = Character(letter)
                    letterIsInWord = true
                }
            }
            
            wordLabel.text = String(wordLabelChars)
        }
        
        return letterIsInWord
    }
    
    func checkVictory() -> Bool {
        
        if let currentGuess = wordLabel.text {
            if currentGuess.contains("?") {
                return false
            }
        }
        
        print("Ganhou!")
        return true
    }
    
    func showAlertController(alertTitle: String, alertMessage: String, actionTitle: String) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: getNewWord))
        present(alertController, animated: true, completion: nil)
    }
}
