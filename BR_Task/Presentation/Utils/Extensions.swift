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
    
    func showMultipleAlert(title: String? = nil, with message: String, preferredStyle: UIAlertController.Style = .alert, actions: [(title: String,style: UIAlertAction.Style)] = [("OK", .default)], completion: ((_ at: Int, _ type: UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    
        for (index, action) in actions.enumerated() {
            let action = UIAlertAction(title: action.title, style: action.style) { (action) in
                completion?(index, action)
            }
            alert.addAction(action)
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension String {
    var cardFormatted: String {
        let lastFourNumber = String(dropFirst(12))
        return "** " + "\(lastFourNumber)"
    }
}

extension UITextField {
    func setRightIcon(_ image: UIImage) {

        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 7, width: 15, height: 15))
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 35, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}
