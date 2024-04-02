//
//  CardInfoEntity+CoreDataProperties.swift
//  BR_Task
//
//  Created by Nazim Asadov on 01.04.24.
//
//

import Foundation
import CoreData


extension CardInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardInfoEntity> {
        return NSFetchRequest<CardInfoEntity>(entityName: "CardInfoEntity")
    }

    @NSManaged public var insertedDate: Date?
    @NSManaged public var cardNumber: String?
    @NSManaged public var expireDate: String?
    @NSManaged public var cvv: String?
    @NSManaged public var fullname: String?
    @NSManaged public var amount: String?

}

extension CardInfoEntity : Identifiable {

}
