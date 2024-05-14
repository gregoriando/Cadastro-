//
//  ZipCode.swift
//  Cadastro
//
//  Created by Gregory Luiz lopes freire on 10/05/24.
//

import Foundation


struct ZipCodeInfo: Decodable {
    
    let cep: String
    let state: String
    let city: String
    let neighborhood: String
    let street: String
    let service: String
}


