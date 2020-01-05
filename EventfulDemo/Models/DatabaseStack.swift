//
//  DatabaseStack.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/4/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import CoreData

protocol DatabaseStack {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
}

final class DatabaseStackImpl: DatabaseStack {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
