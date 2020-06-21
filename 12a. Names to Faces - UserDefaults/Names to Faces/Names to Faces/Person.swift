//
//  Person.swift
//  Names to Faces
//
//  Created by Tomás Santiago on 03/05/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

//Universal Base Class. Todas as classes no UIKIt vêm de Universal Base Class.
//Há comportamentos que só temos se herdarmos de NSObject.

//NSCoding requer o uso de classes.
class Person: NSObject, NSCoding {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    //Lê os dados guardados em disco
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    //Guarda os dados em disco
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
}
