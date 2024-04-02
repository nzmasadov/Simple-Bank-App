//
//  CoreDataManager.swift
//  BR_Task
//
//  Created by Nazim Asadov on 01.04.24.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private init () {}
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    func addUserInfo(name: String, phoneNumber: String, birthday: String, completionHandler: (Result<Data, Error>) -> Void){
        
        let context = persistentContainer.viewContext
        let userInfo = UserInformation(context: context)
        
        userInfo.name = name
        userInfo.phoneNumber = phoneNumber
        userInfo.birthDate = birthday
        userInfo.insertedDate = Date()

        do {
            try context.save()
            completionHandler(.success(Data()))
        } catch let error {
            completionHandler(.failure(error))
        }
    }   
    
    func addUserCardInfo(cardNumber: String, expireDate: String, cvv: String, fullName: String, amount: Double, completionHandler: (Result<Data, Error>) -> Void) {
        
        let context = persistentContainer.viewContext
        let cardInfo = CardInformation(context: context)
        
        cardInfo.cardNumber = cardNumber
        cardInfo.expireDate = expireDate
        cardInfo.cvv = cvv
        cardInfo.fullname = fullName
        cardInfo.insertedDate = Date()
        cardInfo.amount = String(amount)
        
        do {
            try context.save()
            completionHandler(.success(Data()))
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchUserInfo(completionHandler: (Result<[UserInformation], Error>) -> Void) {
        let context = persistentContainer.viewContext
        
        let analysesFetch: NSFetchRequest<UserInformation> = UserInformation.fetchRequest()
        
        do {
            let results = try context.fetch(analysesFetch)
            completionHandler(.success(results))
        }catch let error as NSError {
            completionHandler(.failure(error))
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: type.description())
            let fetchItem = try persistentContainer.viewContext.fetch(fetchRequest)
            return fetchItem
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
