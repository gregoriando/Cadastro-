import UIKit

class CepViewController: UIViewController {
    
    //uiComponents
    private var service = ZipCodeService()
    
    lazy var zipCodeField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "CEP"
        textField.textField.placeholder = "Digite o CEP"
        return textField
    }()
    
    lazy var streetField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Rua"
        textField.textField.placeholder = "Digite o Nome da sua Rua"
        return textField
    }()
    
    lazy var numberField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Número"
        textField.textField.placeholder = "Digite o seu Número"
        return textField
    }()
    
    lazy var neighborhoodField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Bairro"
        textField.textField.placeholder = "Digite o seu Bairro"
        return textField
    }()
    
    lazy var cityField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Cidade"
        textField.textField.placeholder = "Digite a sua cidade"
        return textField
    }()
    
    lazy var stateField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Estado"
        textField.textField.placeholder = "Digite o seu Estado"
        return textField
    }()
    
    lazy var alertConfirmButton: UIAlertController = {
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
        setupView()
        zipCodeField.textField.addTarget(self, action: #selector(autoComplete), for: .editingChanged)
    }
    
    private func validadeFields() -> Bool {
        guard let zipcode = zipCodeField.textField.text , !zipcode.isEmpty,
              let street = streetField.textField.text, !street.isEmpty,
              let number = numberField.textField.text, !number.isEmpty,
              let neighborhood = neighborhoodField.textField.text, !neighborhood.isEmpty,
              let city = cityField.textField.text, !city.isEmpty,
              let state = stateField.textField.text, !state.isEmpty else {
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
    
    private func fetchCep() async {
        guard let zipCode = zipCodeField.textField.text else {return}
        do {
            let zipCodeInfo = try await service.getZipCodes(zipCode: zipCode)
            streetField.textField.text =  zipCodeInfo.street
            neighborhoodField.textField.text = zipCodeInfo.neighborhood
            cityField.textField.text = zipCodeInfo.city
            stateField.textField.text = zipCodeInfo.state
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
extension CepViewController: ViewCodeType {
    func buildViewHierachy() {
        view.addSubview(zipCodeField)
        view.addSubview(streetField)
        view.addSubview(numberField)
        view.addSubview(neighborhoodField)
        view.addSubview(cityField)
        view.addSubview(stateField)
        view.addSubview(confirmButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            zipCodeField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            zipCodeField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            zipCodeField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zipCodeField.heightAnchor.constraint(equalToConstant: 70),
            
            streetField.topAnchor.constraint(equalTo: zipCodeField.bottomAnchor, constant: 20),
            streetField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            streetField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            streetField.heightAnchor.constraint(equalToConstant: 70),
            
            numberField.topAnchor.constraint(equalTo: streetField.bottomAnchor, constant: 20),
            numberField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numberField.heightAnchor.constraint(equalToConstant: 70),
            
            
            neighborhoodField.topAnchor.constraint(equalTo: numberField.bottomAnchor, constant: 20),
            neighborhoodField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            neighborhoodField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            neighborhoodField.heightAnchor.constraint(equalToConstant: 70),
            
            
            cityField.topAnchor.constraint(equalTo: neighborhoodField.bottomAnchor, constant: 20),
            cityField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cityField.heightAnchor.constraint(equalToConstant: 70),
            
            
            stateField.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: 20),
            stateField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stateField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stateField.heightAnchor.constraint(equalToConstant: 70),
            
            confirmButton.topAnchor.constraint(equalTo: stateField.bottomAnchor, constant: 20),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    func setupAddicionalConfiguration() {
        view.backgroundColor = .background
        title = "Continuação do Cadastro"
        navigationItem.hidesBackButton = true
    }
}


//#Preview {
//    cepViewController()
//}
