//
//  PetitionDetailsViewController.swift
//  White House Petitions
//
//  Created by Tomás Santiago on 19/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class PetitionDetailsViewController: UIViewController {
    
    var textLabel: String?
    
    @IBOutlet weak var PetitionDetailsOutlet: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let text = textLabel {
            PetitionDetailsOutlet.isEditable = false
            PetitionDetailsOutlet.text = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
