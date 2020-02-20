//
//  ViewController.swift
//  Auto Layout Part 2
//
//  Created by Tomás Santiago on 17/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let labelOne = UILabel()
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        //Tenho que fazer as minhas próprias constraints à mão.
        labelOne.backgroundColor = .red
        labelOne.text = "THESE"
        //View usa a quantidade de espaço mais apropriada.
        labelOne.sizeToFit()
        
        let labelTwo = UILabel()
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.backgroundColor = .cyan
        labelTwo.text = "ARE"
        labelTwo.sizeToFit()
        
        let labelThree = UILabel()
        labelThree.translatesAutoresizingMaskIntoConstraints = false
        labelThree.backgroundColor = .yellow
        labelThree.text = "SOME"
        labelThree.sizeToFit()
        
        let labelFour = UILabel()
        labelFour.translatesAutoresizingMaskIntoConstraints = false
        labelFour.backgroundColor = .green
        labelFour.text = "AWESOME"
        labelFour.sizeToFit()
        
        let labelFive = UILabel()
        labelFive.translatesAutoresizingMaskIntoConstraints = false
        labelFive.backgroundColor = .orange
        labelFive.text = "LABELS"
        labelFive.sizeToFit()
        
        //Labels são colocados na posição default da view que é no canto superior direito.
        view.addSubview(labelOne)
        view.addSubview(labelTwo)
        view.addSubview(labelThree)
        view.addSubview(labelFour)
        view.addSubview(labelFive)
        
//        let viewDictionary = ["LabelOne": labelOne, "LabelTwo": labelTwo, "LabelThree": labelThree, "LabelFour": labelFour, "LabelFive": labelFive]
//
//        for label in viewDictionary.keys {
//            //view representa a view principal para este view controller.
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary))
//            //H = horizontal layout.
//            // | = edge of the view controller.
//            // Quero que esta view vá para o canto da minha view.
//        }
//
//        let metricsDictionary = ["labelHeight": 88]
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[LabelOne(labelHeight@999)]-[LabelTwo(LabelOne)]-[LabelThree(LabelOne)]-[LabelFour(LabelOne)]-[LabelFive(LabelOne)]-(>=10)-|", options: [], metrics: metricsDictionary, views: viewDictionary))
        //Não colocamos o | a seguir ao labelFive porque não queremos que a última label se estique até ao fim da view controller.
        //@999 é a prioridade com que a constraint é aplicada. Nos outros dizemos que queremos igual à LabelOne.
        
        //As 20 linhas para cima não são necessárias se tivermos o que está em baixo. Em baixo é muito mais expressivo do que em cima.
        
        
        var previous: UILabel?
        
        for label in [labelOne, labelTwo, labelThree, labelFour, labelFive] {
            
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            //Desafio leading e trailing anchor.
            
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.20, constant: -10).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            }
            else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
    }
}
