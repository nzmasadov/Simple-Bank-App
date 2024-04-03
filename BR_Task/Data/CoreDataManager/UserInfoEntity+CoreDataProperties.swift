//
//  UserInfoEntity+CoreDataProperties.swift
//  BR_Task
//
//  Created by Nazim Asadov on 03.04.24.
//
//

import Foundation
import CoreData


extension UserInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfoEntity> {
        return NSFetchRequest<UserInfoEntity>(entityName: "UserInfoEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var birthday: String?

}

extension UserInfoEntity : Identifiable {

}
