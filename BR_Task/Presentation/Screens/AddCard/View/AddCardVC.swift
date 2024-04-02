//
//  AddCardVC.swift
//  BR_Task
//
//  Created by Nazim Asadov on 29.03.24.
//

import UIKit

class AddCardVC: UIViewController {
    
    //MARK: - Variables
    
    private lazy var vm = AddCardVM()
    
    //MARK: - UI Components

    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "Add your card"
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
    
    private lazy var cardNumberStack: UIStackView = {
       let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var cardNumberLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Card Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var cardNumberField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "Add your card number"
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        
        view.addSubview(field)
        return field
    }()
    
    private lazy var containerSubStack: UIStackView = {
       let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var expireDateStack: UIStackView = {
       let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var expireDateLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Expire date"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var expireDateField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "Expire date"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.keyboardType = .numberPad
        field.delegate = self
        
        view.addSubview(field)
        return field
    }()   
    
    private lazy var cvvStack: UIStackView = {
       let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var cvvDateLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "CVV"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var cvvField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "CVV"
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        
        view.addSubview(field)
        return field
    }()    
    
    private lazy var fullnameStack: UIStackView = {
       let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var fullnameLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        return label
    }()
    
    private lazy var fullnameField: BaseTextField = {
        let field = BaseTextField()
        
        field.placeholder = "FULL NAME"
        field.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(field)
        return field
    }()
    
    private lazy var nextBtn: UIButton = {
       let button = UIButton()
        
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        
        view.addSubview(button)
        return button
    }()
    
    //MARK: - Pattern Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstaints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc private func nextPressed() {
        let vc = Router.getUserCardsVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddCardVC {
    private func setupUI() {
        view.backgroundColor = .white
        [cardNumberLbl, cardNumberField].forEach { textfield in
            cardNumberStack.addArrangedSubview(textfield)
        }
        
        [expireDateLbl, expireDateField].forEach { textfield in
            expireDateStack.addArrangedSubview(textfield)
        }
        
        [cvvDateLbl, cvvField].forEach { textfield in
            cvvStack.addArrangedSubview(textfield)
        }
        
        [fullnameLbl, fullnameField].forEach { textfield in
            fullnameStack.addArrangedSubview(textfield)
        }
        
        [expireDateStack, cvvStack].forEach { stack in
            containerSubStack.addArrangedSubview(stack)
        }
        
        [cardNumberStack, containerSubStack, fullnameStack].forEach { stack in
            fieldsContainerStack.addArrangedSubview(stack)
        }
    }
    
    private func setupConstaints() {
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nextBtn.heightAnchor.constraint(equalToConstant: 50),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            fieldsContainerStack.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 50),
            fieldsContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fieldsContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldsContainerStack.bottomAnchor.constraint(lessThanOrEqualTo: nextBtn.topAnchor, constant: -20),
        
            
            cardNumberField.heightAnchor.constraint(equalToConstant: 44),
            expireDateField.heightAnchor.constraint(equalToConstant: 44),
            cvvField.heightAnchor.constraint(equalToConstant: 44),
            fullnameField.heightAnchor.constraint(equalToConstant: 44),
            
            cardNumberStack.trailingAnchor.constraint(equalTo: cardNumberStack.superview!.trailingAnchor),
            cardNumberStack.leadingAnchor.constraint(equalTo: cardNumberStack.superview!.leadingAnchor),
            fullnameStack.trailingAnchor.constraint(equalTo: fullnameStack.superview!.trailingAnchor),
            fullnameStack.leadingAnchor.constraint(equalTo: fullnameStack.superview!.leadingAnchor),
        ])
    }
}

extension AddCardVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else {return false}
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case cardNumberField:
             cardNumberField.text = vm.formatNumber(with: "XXXX XXXX XXXX XXXX", number: newString)
            return false
        case cvvField:
            let maxLength = 3
            return newString.count <= maxLength
        case expireDateField:
            let maxLength = 5
            var originalText = textField.text

            switch range.location {
            case 2:
                textField.text = originalText?.appending("/")
            case 3:
                originalText = originalText?.replacingOccurrences(of: "/", with: "")
                textField.text = originalText
            default: break
            }
            return newString.count <= maxLength

        default:
            return false
        }
    }
}
