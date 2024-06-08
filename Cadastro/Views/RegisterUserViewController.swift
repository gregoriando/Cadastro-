import UIKit

class RegisterUserViewController: UIViewController {
    
    // UIComponents
    
    let datePicker = UIDatePicker()

    lazy var nameField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Nome"
        textField.textField.placeholder = "Digite seu Nome Completo"
        return textField
    }()
    
    lazy var emailField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Email"
        textField.textField.placeholder = "Digite seu Email"
        return textField
    }()
    
    lazy var birthDayField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Data de Nascimento"
        textField.textField.placeholder = "Digite seu Nascimento"
        return textField
    }()
    
    lazy var alertConfirmButton: UIAlertController = {
        let alert = UIAlertController(title: "Alerta", message: "Por Favor Preencha todos os Campos", preferredStyle: .alert)
        let Ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(Ok)
        return alert
    }()
    
    lazy var confirmButtonField: UIButton = {
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
    }
    

    // Validar todos os campos preenchidos
    func validadeFields() -> Bool {
        return ![nameField, emailField, birthDayField].contains { $0.textField.text?.isEmpty ?? true }
    }
    
    @objc func confirmedFieldsButton() {
        if validadeFields() {
            let cepViewController = CepViewController()
            navigationController?.pushViewController(cepViewController, animated: true)
        } else {
            present(alertConfirmButton, animated: true, completion: nil)
        }
    }
    
   //  Lógica para a Toobar do birthDate
        private func createToolbar() -> UIToolbar {
            //toobar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            //Done button
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneButton], animated: true)
            return toolbar
        }
        
        private func createDatePicker() {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
            birthDayField.textField.inputView = datePicker
            birthDayField.textField.inputAccessoryView = createToolbar()
        }
        
        @objc private func donePressed() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "pt_BR")
            birthDayField.textField.text = dateFormatter.string(from: datePicker.date)
            view.endEditing(true)
        }
}
extension RegisterUserViewController: ViewCodeType {
    func buildViewHierachy() {
        view.addSubview(nameField)
        view.addSubview(emailField)
        view.addSubview(birthDayField)
        view.addSubview(confirmButtonField)
    }
    
    func setupConstraints() {
       NSLayoutConstraint.activate([
        
        nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
        nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        nameField.heightAnchor.constraint(equalToConstant: 70),
        
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
        emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        emailField.heightAnchor.constraint(equalToConstant: 70),
        
        birthDayField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
        birthDayField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        birthDayField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        birthDayField.heightAnchor.constraint(equalToConstant: 70),
        
        confirmButtonField.topAnchor.constraint(equalTo: birthDayField.bottomAnchor, constant: 30),
        confirmButtonField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        confirmButtonField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
       ])
   }
    
    func setupAddicionalConfiguration() {
        view.backgroundColor = .background
        title = "Cadastro De Usuário"
        createDatePicker()
       
    }
}

#Preview {
    RegisterUserViewController()
}
