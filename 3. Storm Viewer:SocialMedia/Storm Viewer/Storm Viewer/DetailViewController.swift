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
        
        //#selector diz ao compilador de Swift que um método chamado shareTapped irá existir. Este método deverá ser ativado quando o botão for premido.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

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
    
    //Precisamos do @objc porque este método vai ser chamado pelo sistema operativo em objective-c. Quando um método é chamado com o #selector vai sempre precisar do @objc atrás.
    @objc func shareTapped() {
        
        guard let imageToShare = ImageView.image?.jpegData(compressionQuality: 1)
            else {
            print("No image found.")
                return
        }
        
        let viewController = UIActivityViewController(activityItems: [imageToShare, selectedImage!], applicationActivities: [])
        //Ao adicionar a parte de selectedImage! vou também o nome da imagem lá presente quando clico no botão de share.
        
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(viewController, animated: true)
    }
    
    //Para isto tudo funcionar precisamos de ir a info.plist e adicionar uma nova linha para lidar com os direitos de privacidade do utilizador.
    //Privacy - Photo Library Additions Usage Description.
    //À frente colocamos uma descrição de como é que a foto vai ser usado por parte da aplicação para que o utilizador possa ter a certeza que quer partilhar a foto que vai ser guardada com outras aplicações.
}
