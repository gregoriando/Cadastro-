import UIKit

class cepViewController: UIViewController {
    
    //uiComponents
    private var service = ZipCodeService()
    private lazy var zipcodeLabel = setupLabel(text: "CEP: ")
    private lazy var streetcodeLabel = setupLabel(text: "Rua: ")
    private lazy var numberLabel = setupLabel(text: "Número: ")
    private lazy var neighborhoodLabel = setupLabel(text: "Bairro: ")
    private lazy var cityLabel = setupLabel(text: "Cidade: ")
    private lazy var stateLabel = setupLabel(text: "Estado: ")
    private lazy var zipcodeTextField = setupTextField(placeHolder: "Digite o Cep")
    private lazy var streetTextField = setupTextField(placeHolder: "Digite a Rua")
    private lazy var numberTextField = setupTextField(placeHolder: "Digite o Número e o complemento se houver")
    private lazy var neighborhoodTextField = setupTextField(placeHolder: "Digito o Bairro")
    private lazy var cityTextField = setupTextField(placeHolder: "Digite a Cidade")
    private lazy var stateTextField = setupTextField(placeHolder: "Digite o Estado")
    
    private lazy var zipcodeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [zipcodeLabel, zipcodeTextField,streetcodeLabel, streetTextField, numberLabel, numberTextField,neighborhoodLabel,neighborhoodTextField,cityLabel,cityTextField,stateLabel,stateTextField])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    
    
    
    
    private lazy var alertConfirmButton: UIAlertController = {
        let alert = UIAlertController(title: "Alerta", message: "Por Favor Preencha todos os Campos", preferredStyle: .alert)
        
        let Ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(Ok)
        return alert
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 25
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(confirmedFieldsButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        title = "Continuação do Cadastro"
        navigationItem.hidesBackButton = true
        addSubviews()
        setupConstraints()
        zipcodeTextField.addTarget(self, action: #selector(autoComplete), for: .editingChanged)
    }
    
    private func addSubviews(){
        view.addSubview(zipcodeStack)
        view.addSubview(confirmButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            zipcodeStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            zipcodeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            zipcodeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.topAnchor.constraint(equalTo: zipcodeStack.bottomAnchor, constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: zipcodeStack.leadingAnchor, constant: 50),
            confirmButton.trailingAnchor.constraint(equalTo: zipcodeStack.trailingAnchor, constant: -50)
        ])
    }
    //MEthods for style label and text field
    private func setupLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .left
        label.textColor = .white
        return label
    }
    
    private func setupTextField(placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeHolder
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }
    
    private func validadeFields() -> Bool {
        guard let zipcode = zipcodeTextField.text , !zipcode.isEmpty,
              let street = streetTextField.text, !street.isEmpty,
              let number = numberTextField.text, !number.isEmpty,
              let neighborhood = neighborhoodLabel.text, !neighborhood.isEmpty,
              let city = cityTextField.text, !city.isEmpty,
              let state = stateTextField.text, !state.isEmpty else {
            return false
        }
        return true
    }
    
    @objc private func confirmedFieldsButton(){
        if validadeFields() {
            let usersViewController = UserViewController()
            navigationController?.pushViewController(usersViewController, animated: true)
        }else {
            present(alertConfirmButton, animated: true, completion: nil)
        }
    }
    
    //fetch cep
    private func fetchCep() async {
        guard let zipCode = zipcodeTextField.text else {return}
        do {
            let zipCodeInfo = try await service.getZipCodes(zipCode: zipCode)
            streetTextField.text =  zipCodeInfo.street
            neighborhoodTextField.text = zipCodeInfo.neighborhood
            cityTextField.text = zipCodeInfo.city
            stateTextField.text = zipCodeInfo.state
        } catch {
            print(" Erro ao obter informações do CEP: ", error)
        }
    }
    @objc private func autoComplete() {
        Task {
            await fetchCep()
        }
    }
}

#Preview {
    cepViewController()
}
