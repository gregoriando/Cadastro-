//
//  CustomTextField.swift
//  Cadastro
//
//  Created by Gregory Luiz lopes freire on 06/06/24.
//

import UIKit

class CustomTextField: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var containerTextFieldView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowRadius = 4
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowOpacity = 0.5
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 8
        return uiView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension CustomTextField: ViewCodeType {
    
    func buildViewHierachy() {
        addSubview(titleLabel)
        addSubview(containerTextFieldView)
        addSubview(textField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            containerTextFieldView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            containerTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerTextFieldView.heightAnchor.constraint(equalToConstant: 40),
            
            textField.leadingAnchor.constraint(equalTo: containerTextFieldView.leadingAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: containerTextFieldView.trailingAnchor, constant: -5),
            textField.centerYAnchor.constraint(equalTo: containerTextFieldView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
