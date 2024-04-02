//
//  BaseTextField.swift
//  BR_Task
//
//  Created by Nazim Asadov on 29.03.24.
//

import UIKit

final class BaseTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 12
        font = UIFont.systemFont(ofSize: 14)
    }
}
