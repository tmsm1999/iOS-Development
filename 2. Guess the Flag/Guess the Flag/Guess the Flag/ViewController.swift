//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Tomás Santiago on 12/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Primeira parte - Interface Builder
    //Arrastei 3 butões.
    //Adicionei as constraints com AutoLayout. Ctrl + drag para cima.
    //Para o primeiro botão escolhi Top Space to Safe Area e Center Horizontally in safe area.
    //Para o segundo botão escolhi vertical spacing e center horizontally. Arrastei do segundo botão e larguei no primeiro.
    //Para o terceiro botão escolhi vertical spacing e center horizontally. Arrastei do terceiro botão e larguei no segundo.
    //No final o primeiro botão ainda não estava no sítio, portanto carreguei nele e fui a Editor -> Resolve Auto Layout Issues -> Update frames.
    
    
    @IBOutlet var ButtonOne: UIButton!
    @IBOutlet var ButtonTwo: UIButton!
    @IBOutlet var ButtonThree: UIButton!
    
    var countries = [String]()
    var score: Int = 0
    var correctAnswer: Int = 0
    var questionsAsked: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        //Estamos a usar CALayer, que faz parte de core animation e que é responsável por por gerir como é a aparência da view.
        ButtonOne.layer.borderWidth = 1
        ButtonTwo.layer.borderWidth = 1
        ButtonThree.layer.borderWidth = 1
        
        ButtonOne.layer.borderColor = UIColor.lightGray.cgColor
        ButtonTwo.layer.borderColor = UIColor.lightGray.cgColor
        ButtonThree.layer.borderColor = UIColor.lightGray.cgColor
        
        ButtonOne.tag = 0
        ButtonTwo.tag = 1
        ButtonThree.tag = 2
        
        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showScore))
    }
    
//    Swift wants the method to accept a UIAlertAction parameter saying which UIAlertAction was tapped.
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle() //Baralha os elementos do array.
        correctAnswer = Int.random(in: 0...2)
        //Escolhe qual é que o utilizador tem que adivinhar.
        
        ButtonOne.setImage(UIImage(named: countries[0]), for: .normal)
        ButtonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        ButtonThree.setImage(UIImage(named: countries[2]), for: .normal)
        
        //O .normal diz para que estado é que o botão deve ser mudado. O .normal significa o "estado normal do botão."
        
        title = "Guess next: " + countries[correctAnswer].uppercased()
    }
    
    //Handler para quando o jogo termina.
    func finalScreen(action: UIAlertAction!) {
        ButtonOne.isHidden = true
        ButtonTwo.isHidden = true
        ButtonThree.isHidden = true
        
        title = "Final score = \(score)"
    }
    
    @objc func showScore() {
        
        let scoreAlert = UIAlertController(title: "Current Score", message: "Your current score is \(score).", preferredStyle: .alert);
        
        scoreAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        present(scoreAlert, animated: true)
    }
    
    //Triggers code
    @IBAction func buttonTapped(_ sender: UIButton) {
        var result: Int = 0
        
        if sender.tag == correctAnswer {
            result = 1
            score += 1
        }
        else {
            result = 0
            score -= 1
            
            if score < 0 {
                score = 0
            }
        }
        
        questionsAsked += 1
        
        if questionsAsked == 10 {
            
            let finalAlertView = UIAlertController(title: "Game Finished", message: "Your final score is \(score).", preferredStyle: .alert)
            
            finalAlertView.addAction(UIAlertAction(title: "Continue", style: .default, handler: finalScreen))
            
            present(finalAlertView, animated: true)
        }
        else {
            //Cria um alerta
            let alertView: UIAlertController!
            
            if result == 1 {
                alertView = UIAlertController(title: "Correct!", message: "Your score is \(score).", preferredStyle: .alert)
            }
            else {
                alertView = UIAlertController(title: "Wrong! That is the flag of " + countries[sender.tag].uppercased(), message: "Your score is \(score).", preferredStyle: .alert)
            }
           
           alertView.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
           
           present(alertView, animated: true)
        }
    }
}
