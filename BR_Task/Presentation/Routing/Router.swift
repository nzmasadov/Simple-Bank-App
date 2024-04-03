//
//  Router.swift
//  BR_Task
//
//  Created by Nazim Asadov on 28.03.24.
//

import Foundation

final class Router {
    private init() {}
    
    static func getRegisterVC() -> RegisterVC {
        let vc = RegisterVC()
        return vc
    }    
    
    static func getAddCardVC() -> AddCardVC {
        let vc = AddCardVC()
        return vc
    }    
    
    static func getUserCardsVC() -> UserCardsVC {
        let vc = UserCardsVC()
        return vc
    }    
    
    static func getTransferVC() -> TransferVC {
        let vc = TransferVC()
        return vc
    }
}
