//
//  TransferVC.swift
//  BR_Task
//
//  Created by Nazim Asadov on 03.04.24.
//

import UIKit

class TransferVC: UIViewController {
    
    var userCards: [CardInfoEntity] = []
//    var fromCard: CardInfoEntity?
    
    var cardSelectedIndex = 0
    private var selectedIndex = 0
    
    private lazy var myPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "Transfer"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var fieldsContainerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var fromStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var fromLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "from"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var fromField: BaseTextField = {
        let field = BaseTextField()
        
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.isEnabled = false
        
        view.addSubview(field)
        return field
    }()
    
    private lazy var toStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var toLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "to"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var toField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "Choose card number"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        
        view.addSubview(field)
        return field
    }()
    
    private lazy var amountStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var amountLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Amount"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var amountField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "Add amount"
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        
        view.addSubview(field)
        return field
    }()
    
    private lazy var sendBtn: UIButton = {
        let button = UIButton()
        
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        
        view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstaints()
        setupPicker()
        
        toField.rightViewMode = UITextField.ViewMode.always
        toField.rightViewMode = .always
        
        toField.setRightIcon(.dropDownIcon)
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc private func sendPressed() {        
        let allFieldsHaveText = [fromField, toField, amountField].allSatisfy({!$0.text!.isEmpty})
        let balance = Double(userCards[cardSelectedIndex].amount ?? "") ?? 0
        let creditAmount = Double(amountField.text!) ?? 0
        
        switch (allFieldsHaveText, (creditAmount < balance)) {
            case (true, true):
            updateDatabase()
        case (false, true):
            self.showAlertWith(title: "Warning", message: "Fields cannot be empty!")
        case (true, false):
            self.showAlertWith(title: "Warning", message: "Please check the amount is correct")
        default:
            break
        }
    }
}

extension TransferVC {
    private func setupUI() {
        view.backgroundColor = .white
        
        fromField.text = userCards[cardSelectedIndex].cardNumber?.cardFormatted
        [fromLbl, fromField].forEach { textfield in
            fromStack.addArrangedSubview(textfield)
        }
        
        [toLbl, toField].forEach { textfield in
            toStack.addArrangedSubview(textfield)
        }
        
        [amountLbl, amountField].forEach { textfield in
            amountStack.addArrangedSubview(textfield)
        }
        
        
        [fromStack, toStack, amountStack].forEach { stack in
            fieldsContainerStack.addArrangedSubview(stack)
        }
    }
    
    private func setupConstaints() {
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            sendBtn.heightAnchor.constraint(equalToConstant: 50),
            sendBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            fieldsContainerStack.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 50),
            fieldsContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fieldsContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldsContainerStack.bottomAnchor.constraint(lessThanOrEqualTo: sendBtn.topAnchor, constant: -20),
            
            fromField.heightAnchor.constraint(equalToConstant: 44),
            toField.heightAnchor.constraint(equalToConstant: 44),
            amountField.heightAnchor.constraint(equalToConstant: 44),
            
            fromStack.trailingAnchor.constraint(equalTo: fromStack.superview!.trailingAnchor),
            toStack.trailingAnchor.constraint(equalTo: toStack.superview!.trailingAnchor),
            amountStack.trailingAnchor.constraint(equalTo: amountStack.superview!.trailingAnchor),
        ])
    }
    
    private func setupPicker() {
        
        myPicker.dataSource = self
        myPicker.delegate = self
        
        toField.inputView = myPicker
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        
        toField.inputAccessoryView = toolbar
    }
    
    private func updateDatabase() {
        let manager = CoreDataManager.shared
        manager.updateCardAmount(fromCard: userCards[cardSelectedIndex], toCard: userCards[selectedIndex], amount: Double(amountField.text!) ?? 0.0) { [weak self] results in
            guard let self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func donePicker() {
        if selectedIndex != cardSelectedIndex {
            toField.text = userCards[selectedIndex].cardNumber?.cardFormatted ?? "-"
            toField.resignFirstResponder()
        }else {
            self.showAlertWith(title: "Warning", message: "Transfer to own card is not allowable")
        }
    }
}

extension TransferVC: UITextFieldDelegate {
    
}

extension TransferVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userCards.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = .label
        pickerLabel.text = userCards[row].cardNumber?.cardFormatted
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.layer.cornerRadius = pickerLabel.frame.height/2.0
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
}
