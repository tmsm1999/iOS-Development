//
//  showFlagImageViewController.swift
//  Consolidation Two
//
//  Created by Tomás Santiago on 17/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

class showFlagImageViewController: UIViewController {
    
    @IBOutlet var flagImageView: UIImageView!
    var flagImageSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

        if let selectedImage = flagImageSelected {
            
            flagImageView.image = UIImage(named: selectedImage)
            flagImageView.layer.borderColor = UIColor.lightGray.cgColor
            flagImageView.layer.borderWidth = 1
            
            let flagTitle = selectedImage
            title = String(flagTitle.dropFirst(5).dropLast(4)).uppercased()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showShareButton))
    }
    
    @objc func showShareButton() {
        
        guard let imageToShare = flagImageView.image?.jpegData(compressionQuality: 1) else {
            return
        }
        
        let shareView = UIActivityViewController(activityItems: [imageToShare, flagImageSelected!], applicationActivities: [])
        
        present(shareView, animated: true)
    }
}
