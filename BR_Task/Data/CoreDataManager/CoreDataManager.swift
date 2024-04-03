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
        let container = NSPersistentContainer(name: "UserCoreDataManager")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    func addUserInfo(name: String, phoneNumber: String, birthday: String, completionHandler: (Result<Data, Error>) -> Void){
        
        let context = persistentContainer.viewContext
        let userInfo = UserInfoEntity(context: context)
        
        userInfo.name = name
        userInfo.phoneNumber = phoneNumber
        userInfo.birthday = birthday

        do {
            try context.save()
            completionHandler(.success(Data()))
        } catch let error {
            completionHandler(.failure(error))
        }
    }   
    
    func addCard(cardNumber: String, expireDate: String, cvv: String, fullName: String, amount: Double, completionHandler: (Result<Data, Error>) -> Void) {
        
        let context = persistentContainer.viewContext
        let cardInfo = CardInfoEntity(context: context)
        
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
    
    func fetchData<T: NSManagedObject>(_ type: T.Type) -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: type.description())
            let fetchItem = try persistentContainer.viewContext.fetch(fetchRequest)
            return fetchItem
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func updateCardAmount(fromCard: CardInfoEntity?, toCard: CardInfoEntity?, amount: Double, completionHandler: (Result<Data, Error>) -> Void) {
        let context = persistentContainer.viewContext
        
        let fromCardFetch: NSFetchRequest<CardInfoEntity> = CardInfoEntity.fetchRequest()
        fromCardFetch.fetchLimit = 1
        fromCardFetch.predicate =  NSPredicate(format: "SELF = %@", (fromCard?.objectID ?? ""))
        let resultsFromFetch = try? persistentContainer.viewContext.fetch(fromCardFetch)
        
        let toCardFetch: NSFetchRequest<CardInfoEntity> = CardInfoEntity.fetchRequest()
        toCardFetch.fetchLimit = 1
        toCardFetch.predicate =  NSPredicate(format: "SELF = %@", (toCard?.objectID ?? ""))
        let resultsToFetch = try? persistentContainer.viewContext.fetch(toCardFetch)
        
        var fromDataEntity: CardInfoEntity?
        var toDataEntity: CardInfoEntity?
                
        fromDataEntity = resultsFromFetch?.first
        toDataEntity = resultsToFetch?.first
        
        let fromAmount = Double(fromDataEntity?.amount ?? "0") ?? 0
        let toAmount = Double(toDataEntity?.amount ?? "0") ?? 0
        
        let differenceFrom = String(fromAmount - amount)
        let differenceTo = String(toAmount + amount)
        
        fromDataEntity?.amount = differenceFrom
        toDataEntity?.amount = differenceTo
        
        do {
            try context.save()
            completionHandler(.success(Data()))
        } catch let error {
            completionHandler(.failure(error))
        }
    } 
    
    func deleteCard(card: CardInfoEntity, completionHandler: (Result<Data, Error>) -> Void) {
        let context = persistentContainer.viewContext
        context.delete(card)
        
        do {
            try context.save()
            completionHandler(.success(Data()))
        }catch let error as NSError {
            completionHandler(.failure(error))
        }
    }
}
