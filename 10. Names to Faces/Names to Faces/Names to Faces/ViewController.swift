//
//  ViewController.swift
//  Names to Faces
//
//  Created by Tomás Santiago on 25/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

//Como fazer uma CollectionView?
//Tal como fiz com as Table view, removemos o controller existe em main.storyboard e adicionamos o novo UICollectionViewController.
//No código também mudamos a super classe para UICollectionViewController.
//No identity inspector temos que alterar a classe.
//Depois editamos a collection view para que a célula tenha as dimensões que queremos. Vamos à barra lateral direita e selecionamos Collection View. No size inspector alteramos as dimensões. Alteramos também o section insets.
//Depois adicionamos uma imagem e um label à célula e editamos ambos no interface builder.

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10 //Para já é este o número de células que vamos ter.
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        
        return collectionCell
    }


}

