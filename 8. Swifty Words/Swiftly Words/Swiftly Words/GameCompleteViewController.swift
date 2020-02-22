//
//  GameCompleteViewController.swift
//  Swiftly Words
//
//  Created by Tomás Santiago on 22/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class GameCompleteViewController: UIViewController {
    
    var completeGameLabel: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        completeGameLabel = UILabel()
        completeGameLabel.text = "GAME COMPLETE!\n🙌🍾😍"
        completeGameLabel.font = UIFont.systemFont(ofSize: 50)
        completeGameLabel.textAlignment = .center
        completeGameLabel.numberOfLines = 0
        completeGameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(completeGameLabel)
        
        let restartButton = UIButton(type: .system)
        restartButton.setTitle("Restart Game", for: .normal)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.layer.borderColor = UIColor.black.cgColor
        restartButton.layer.cornerRadius = 2.5
        restartButton.layer.borderWidth = 1
        restartButton.backgroundColor = UIColor.lightGray
        restartButton.setTitleColor(UIColor.white, for: .normal)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        view.addSubview(restartButton)
        
        NSLayoutConstraint.activate([
            
            completeGameLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            completeGameLabel.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -120),
            
            restartButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: completeGameLabel.bottomAnchor, constant: 50),
            restartButton.widthAnchor.constraint(equalToConstant: 120),
            restartButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
        
    }
    
    override func viewDidLoad() {
        //self.navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func restartGame(_ sender: UIButton) {
        
        let initialViewController = self.storyboard?.instantiateViewController(identifier: "InitialViewController") as! ViewController
        
        navigationController?.pushViewController(initialViewController, animated: true)
    }
    
    

}
