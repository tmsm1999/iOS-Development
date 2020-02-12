//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Tomás Santiago on 11/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import UIKit

//AutoLayout: Carrego na imagem. Editor -> Resolve Auto Layout Issues -> Add Missing Constraints.

class DetailViewController: UIViewController {
    
    @IBOutlet var ImageView: UIImageView!
    var selectedImage: String?
    var index: Int = 0
    var totalPics: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mostra o título da imagem.
        title = "Picture \(index) of \(totalPics)"
        
        //Quando carregamos numa imagem ela vai aparecer na DetailViewController. Aqui não queremos que o título esteja grande.
        navigationItem.largeTitleDisplayMode = .never

        //Executa se não for nil.
        if let imageToLoad = selectedImage {
            ImageView.image = UIImage(named: imageToLoad)
        }
    }
    
    //Quando é true o utilizador pode primir qualquer botão na view em que está para esconder a barra. Quando a imagem está para aparecer esta funcionalidade é ativada.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    //O inverso acontece quando a imagem desaparece.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
}
