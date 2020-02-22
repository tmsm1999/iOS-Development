//
//  ViewController.swift
//  Swiftly Words
//
//  Created by Tomás Santiago on 22/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel?.text = "Score: \(String(score))"
        }
    }
    
    var guessedWords = 0
    var gameLevel = 1
    
    override func loadView() {
        //The UIView class is a concrete class that you can instantiate and use to display a fixed background color.
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        // If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false. Deve ser false quando queremos usar Auto Layout.
        //A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        //To remove any maximum limit, and use as many lines as needed, set the value of this property to 0.
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        answerLabel.textAlignment = .right
        answerLabel.text = "ANSWERS"
        answerLabel.numberOfLines = 0
        answerLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        view.addSubview(answerLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.placeholder = "Tap letters to guess."
        currentAnswer.textAlignment = .center
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        let clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        view.addSubview(clearButton)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        buttonsView.layer.borderWidth = 1
        view.addSubview(buttonsView)
        
        //https://www.tctav.com/en/tech-blog/experience-auto-layout-and-size-classes-ios-part-2-written-cong-pham
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.7, constant: -100),
            
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.3, constant: -100),
            
            answerLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor), //Centra horizontalmente
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let buttonWidth = 150
        let buttonHeight = 80
        
        for row in 0 ... 3 {
            for column in 0 ... 4 {
                
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("www", for: .normal)
                letterButton.layer.borderColor = UIColor.gray.cgColor
                letterButton.layer.borderWidth = 1
                letterButton.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
                
                let buttonFrame = CGRect(x: column * buttonWidth, y: row * buttonHeight, width: buttonWidth, height: buttonHeight)
                letterButton.frame = buttonFrame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
      
//        cluesLabel.backgroundColor = .red
//        answerLabel.backgroundColor = .blue
//        scoreLabel.backgroundColor = .yellow
//        buttonsView.backgroundColor = .green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loadGameLevel()
    }
    
    @objc func letterButtonTapped(_ sender: UIButton) {
        
        guard let buttonTitle = sender.titleLabel?.text else {
            return
        }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        sender.isHidden = true
        activatedButtons.append(sender)
    }
    
    @objc func submitButtonTapped(_ sender: UIButton) {
        
        guard let answer = currentAnswer.text else {
            return
        }
        
        if let solutionPosition = solutions.firstIndex(of: answer) {
            
            activatedButtons.removeAll(keepingCapacity: true)
            
            var splitAnswers = answerLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answer
            answerLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            guessedWords += 1
            
            if guessedWords % 7 == 0 && gameLevel <= 1 {
                
                let alertView = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(alertView, animated: true, completion: nil)
            }
            else if guessedWords % 7 == 0 && gameLevel > 1 {
                levelUp(action: nil)
            }
        }
        else {
            
            let alertView = UIAlertController(title: "Wrong!", message: "The word you entered is not a valid guess.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
            present(alertView, animated: true, completion: nil)
            
            score -= 1
            clearButtonTapped(nil)
        }
    }
    
    @objc func clearButtonTapped(_ sender: UIButton?) {
        
        currentAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll(keepingCapacity: true)
    }
    
    func loadGameLevel() {
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFile = Bundle.main.url(forResource: "level\(gameLevel)", withExtension: "txt") {
            if let levelContent = try? String(contentsOf: levelFile) {
                
                var lines: [String] = levelContent.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    
                    let lineParts: [String] = line.components(separatedBy: ": ")
                    let answer = lineParts[0]
                    let clue = lineParts[1]
                    
                    clueString += "\(index + 1). \(clue).\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    
                    solutions.append(solutionWord)
                    
                    let wordBits = answer.components(separatedBy: "|")
                    letterBits += wordBits
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answerLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count {
            
            for index in 0 ... letterBits.count - 1 {
                letterButtons[index].setTitle(letterBits[index], for: .normal)
            }
        }
    }
    
    func levelUp(action: UIAlertAction?) {
        
        gameLevel += 1
        solutions.removeAll(keepingCapacity: true)
        
        if gameLevel <= 2 {
            loadGameLevel()
            
            for button in letterButtons {
                button.isHidden = false
            }
        }
        else {
            let completeGameViewController = self.storyboard?.instantiateViewController(identifier: "GameCompleteViewController") as! GameCompleteViewController
            
            navigationController?.pushViewController(completeGameViewController, animated: true)
    
        }
    }
}

//For this project your challenge is:

//1 - Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
//2 - If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
//3 - Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.
