//
//  ViewController.swift
//  BR_Task
//
//  Created by Nazim Asadov on 29.03.24.
//

import UIKit

class RegisterVC: UIViewController {
    
    //MARK: - UI Components
    
    let datePicker = UIDatePicker()
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "Registration"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var fieldStack: UIStackView = {
       let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var nameTextField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "Name"
        
        view.addSubview(field)
        return field
    }()    
    
    private lazy var phoneNumberTextField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "Phone Number"
        field.keyboardType = .phonePad
        
        view.addSubview(field)
        return field
    }()    
    
    private lazy var birthdayTextField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "Date of birth"
        
        view.addSubview(field)
        return field
    }()

    private lazy var registerBtn: UIButton = {
       let button = UIButton()
        
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        return button
    }()
    
    //MARK: - Pattern Delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstaints()
        createDatePicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc private func registerPressed() {
        
        let allFieldsHaveText = [nameTextField, phoneNumberTextField, birthdayTextField].allSatisfy({!$0.text!.isEmpty})
        
        if allFieldsHaveText {
            let vc = Router.getAddCardVC()
            vc.userInfo = RegisterModel(name: nameTextField.text!,
                                        birthday: birthdayTextField.text!,
                                        phoneNumber: phoneNumberTextField.text!)
            navigationController?.pushViewController(vc, animated: true)
        }else {
            self.showAlertWith(title: "Warning", message: "Required fields cannot be empty!")
        }
    }
}

extension RegisterVC {
    
    private func setupUI() {
        view.backgroundColor = .white
        [nameTextField, phoneNumberTextField, birthdayTextField].forEach { textfield in
            fieldStack.addArrangedSubview(textfield)
        }
    }
    
    private func setupConstaints() {
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            registerBtn.heightAnchor.constraint(equalToConstant: 50),
            registerBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            fieldStack.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 50),
            fieldStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fieldStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldStack.bottomAnchor.constraint(lessThanOrEqualTo: registerBtn.topAnchor, constant: -20),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension RegisterVC {
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let currentDate = Date()
        let calendar = Calendar.current
        let minDateComponent = DateComponents(year: calendar.component(.year, from: currentDate) - 100, month: 1, day: 1)
        let maxDateComponent = DateComponents(year: calendar.component(.year, from: currentDate) - 18, month: calendar.component(.month, from: currentDate), day: calendar.component(.day, from: currentDate))
        datePicker.minimumDate = calendar.date(from: minDateComponent)
        datePicker.maximumDate = calendar.date(from: maxDateComponent)
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

        birthdayTextField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        birthdayTextField.inputAccessoryView = toolbar
    }
    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: datePicker.date)
        
        birthdayTextField.text = formattedDate
    }
    
    @objc func doneButtonTapped() {
        birthdayTextField.resignFirstResponder()
    }
}
