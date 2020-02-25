//
//  petition.swift
//  White House Petitions
//
//  Created by Tomás Santiago on 19/02/2020.
//  Copyright © 2020 Tomás Santiago. All rights reserved.
//

import Foundation

struct Petition: Codable {
//Adicionando esta linha codable faz com que seja decodable from JSON. Estamos a dizer que esta struct herda propriedades da class codable.
    
    var title: String //Guarda o título da petição.
    var body: String //Guarda o conteúdo da petição.
    var signatureCount: Int //Guarda as assinaturas que a petição tem até ao momento.
}
