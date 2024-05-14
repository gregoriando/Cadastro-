import UIKit

class HomeViewController: UIViewController {
    
    // UIComponents
    
    let datePicker = UIDatePicker()
    
    private lazy var alertConfirmButton: UIAlertController = {
        let alert = UIAlertController(title: "Alerta", message: "Por Favor Preencha todos os Campos", preferredStyle: .alert)
        
        let Ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(Ok)
        return alert
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome: "
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email: "
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var birthDaylLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Data de Nascimento: "
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    private lazy var nameTextField: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Digite Seu Nome Completo"
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont.systemFont(ofSize: 15)
        return textfield
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .emailAddress
        textfield.placeholder = "Digite Seu Email"
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont.systemFont(ofSize: 15)
        return textfield
    }()
    
    private lazy var birthTextField: UITextField = {
        let textfiled = UITextField(frame: .zero)
        textfiled.translatesAutoresizingMaskIntoConstraints = false
        textfiled.placeholder = "Selecione Sua Data de Nascimento"
        textfiled.backgroundColor = .white
        textfiled.textColor = .black
        textfiled.borderStyle = .roundedRect
        textfiled.layer.cornerRadius = 50
        textfiled.font = UIFont.systemFont(ofSize: 15)
        return textfiled
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
        title = "Cadastro De Usuário"
        addSubviews()
        setupConstraints()
        createDatePicker()
    }
    
    private func addSubviews(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(birthDaylLabel)
        stackView.addArrangedSubview(birthTextField)
        view.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            confirmButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
        // Lógica para a Toobar do birthDate
        func createToolbar() -> UIToolbar {
            //toobar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            //Done button
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneButton], animated: true)
            return toolbar
        }
        
        func createDatePicker() {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
            birthTextField.inputView = datePicker
            birthTextField.inputAccessoryView = createToolbar()
        }
        
       @objc func donePressed() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "pt_BR")
            birthTextField.text = dateFormatter.string(from: datePicker.date)
            view.endEditing(true)
        }
    
    //Validar todos os campos preenchidos
    
    private func validadeFields() -> Bool {
        guard let name = nameTextField.text , !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let birthDate = birthTextField.text, !birthDate.isEmpty else {
            return false
        }
        return true
    }
    
    @objc private func confirmedFieldsButton(){
        if validadeFields() {
            let cepViewController = cepViewController()
            navigationController?.pushViewController(cepViewController, animated: true)
        }else {
            present(alertConfirmButton, animated: true, completion: nil)
        }
    }
 
}
#Preview {
    HomeViewController()
}

//Agora Vamos testar o Upload para o repositório com um commit
