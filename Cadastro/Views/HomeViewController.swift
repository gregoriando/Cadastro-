import UIKit

class HomeViewController: UIViewController {
    
    // UIComponents
    
    let datePicker = UIDatePicker()
    
    private lazy var nameLabel = setupLabel(text: "Nome: ")
    private lazy var emailLabel = setupLabel(text: "Email: ")
    private lazy var birthDayLabel = setupLabel(text: "Data de Nascimento: ")
    private lazy var nameTextField = setupTextField(placeHolder: "Digite Seu Nome Completo")
    private lazy var emailTextField = setupTextField(placeHolder: "Digite Seu Email")
    private lazy var birthTextField = setupTextField(placeHolder: "Selecione Sua Data de Nascimento")
    
    private lazy var alertConfirmButton: UIAlertController = {
        let alert = UIAlertController(title: "Alerta", message: "Por Favor Preencha todos os Campos", preferredStyle: .alert)
        let Ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(Ok)
        return alert
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, nameTextField,emailLabel, emailTextField, birthDayLabel, birthTextField])
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        return stack
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
    
    private func setupLabel(text: String) -> UILabel {
        let label = UILabel()
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
    
        // Lógica para a Toobar do birthDate
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
        return ![nameTextField, emailTextField, birthTextField].contains {$0.text?.isEmpty ?? true}
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
