//
//  Extensions.swift
//  BR_Task
//
//  Created by Nazim Asadov on 01.04.24.
//

import UIKit

extension UIViewController {
    func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

