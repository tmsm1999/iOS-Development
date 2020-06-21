//
//  ViewController.swift
//  UserDefaults - Testing
//
//  Created by Tomás Santiago on 21/06/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        //Permite guardar daods da aplicação enquanto ela está instalada no dispositivo. Os dados são carregados automaticamente quando a aplicação é aberta.
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UserFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Tomás Santiago", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Tomás", "Country": "Portugal"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.integer(forKey: "UserFaceID")
        let pi = defaults.float(forKey: "Pi")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let savedDict = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String]()
        
        
        
    }


}

