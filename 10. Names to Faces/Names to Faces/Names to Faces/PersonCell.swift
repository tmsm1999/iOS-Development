//
//  PersonCell.swift
//  Names to Faces
//
//  Created by Tomás Santiago on 25/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

//A célula da collection view precisa de uma classe só para ela porque a célula tem duas views que nós criamos. Por isso precisamos de arranjar uma forma de manipular estes elementos.

class PersonCell: UICollectionViewCell {
    
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var PersonName: UILabel!
    
    
}
