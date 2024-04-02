//
//  AddCardVM.swift
//  BR_Task
//
//  Created by Nazim Asadov on 29.03.24.
//

import Foundation

class AddCardVM {
    
    func formatNumber(with mask: String, number: String) -> String {
        let numbers = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                
                index = numbers.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
