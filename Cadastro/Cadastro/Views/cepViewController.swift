import UIKit

class cepViewController: UIViewController {
    
    //uiComponents
    private var service = ZipCodeService()
    
    private lazy var alertConfirmButton: UIAlertController = {
        let alert = UIAlertController(title: "Alerta", message: "Por Favor Preencha todos os Campos", preferredStyle: .alert)
        
        let Ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(Ok)
        return alert
    }()
    
    private lazy var zipcodeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    private lazy var zipcodeLabel: UILabel = {
        let label = setupLabel(text: "CEP: ")
        return label
    }()
    
    private lazy var zipcodeTextField: UITextField = {
        let textfield = setupTextFiel(placeHolder: "Digite o Cep")
        textfield.addTarget(self, action: #selector(autoComplete), for: .editingChanged)
        return textfield
    }()
    
    private lazy var streetcodeLabel: UILabel = {
        let label = setupLabel(text: "Rua: ")
        return label
    }()
    
    private lazy var streetTextField: UITextField = {
        let textfield = setupTextFiel(placeHolder: "Digite a rua")
        return textfield
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = setupLabel(text: "Numero: ")
        return label
    }()
    
    private lazy var numberTextField: UITextField = {
        let textfield = setupTextFiel(placeHolder: "Digite o complemento")
        return textfield
    }()
    
    private lazy var neighborhoodLabel: UILabel = {
        let label = setupLabel(text: "Bairro: ")
        return label
    }()
    
    private lazy var neighborhoodTextField: UITextField = {
        let textfield = setupTextFiel(placeHolder: "Digite o bairro")
        return textfield
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = setupLabel(text: "Cidade: ")
        return label
    }()
    
    private lazy var cityTextField: UITextField = {
        let textfield = setupTextFiel(placeHolder: "Digite a cidade")
        return textfield
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = setupLabel(text: "Estado: ")
        return label
    }()
    
    private lazy var stateTextField: UITextField = {
        let textfield = setupTextFiel(placeHolder: "Digite o estado")
        return textfield
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
       // zipcodeTextField.addTarget(self, action: #selector(zipcodeTextFieldDidiChange), for: .editingChanged)
    }
    
    private func addSubviews(){
        view.addSubview(zipcodeStack)
        zipcodeStack.addArrangedSubview(zipcodeLabel)
        zipcodeStack.addArrangedSubview(zipcodeTextField)
        zipcodeStack.addArrangedSubview(streetcodeLabel)
        zipcodeStack.addArrangedSubview(streetTextField)
        zipcodeStack.addArrangedSubview(numberLabel)
        zipcodeStack.addArrangedSubview(numberTextField)
        zipcodeStack.addArrangedSubview(neighborhoodLabel)
        zipcodeStack.addArrangedSubview(neighborhoodTextField)
        zipcodeStack.addArrangedSubview(cityLabel)
        zipcodeStack.addArrangedSubview(cityTextField)
        zipcodeStack.addArrangedSubview(stateLabel)
        zipcodeStack.addArrangedSubview(stateTextField)
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
    
    private func setupTextFiel(placeHolder: String) -> UITextField {
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
            self.streetTextField.text =  zipCodeInfo.street
            self.neighborhoodTextField.text = zipCodeInfo.neighborhood
            self.cityTextField.text = zipCodeInfo.city
            self.stateTextField.text = zipCodeInfo.state
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
