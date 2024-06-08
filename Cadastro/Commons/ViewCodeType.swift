//
//  ViewCodeType.swift
//  Cadastro
//
//  Created by Gregory Luiz lopes freire on 06/06/24.
//

import Foundation

protocol ViewCodeType {
    
    func buildViewHierachy()
    func setupConstraints()
    func setupAddicionalConfiguration()
    func setupView()
}

extension ViewCodeType {
    func setupView(){
        buildViewHierachy()
        setupConstraints()
        setupAddicionalConfiguration()
    }
    func setupAddicionalConfiguration(){}
}

