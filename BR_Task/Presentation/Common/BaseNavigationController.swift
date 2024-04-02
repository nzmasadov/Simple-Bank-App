//
//  BaseNavigationController.swift
//  BR_Task
//
//  Created by Nazim Asadov on 29.03.24.
//

import UIKit

final class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = .label
    }
}
