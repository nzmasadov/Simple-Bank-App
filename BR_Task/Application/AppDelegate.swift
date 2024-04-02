//
//  AppDelegate.swift
//  BR_Task
//
//  Created by Nazim Asadov on 28.03.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let userCards = CoreDataManager.shared.fetchData(CardInfoEntity.self)
        let navVC = if userCards.isEmpty {
            BaseNavigationViewController(rootViewController: Router.getRegisterVC())
        }else {
            BaseNavigationViewController(rootViewController: Router.getUserCardsVC())
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navVC

        return true
    }
}
