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

class Person: NSObject {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
