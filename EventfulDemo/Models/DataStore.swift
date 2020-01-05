//
//  DataStore.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/3/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import Foundation
import Combine
import CoreData

protocol DataStore {
    func refreshEventsIfNeed()
}

struct DataStoreParams {
    struct DataStoreConfig {
        var cacheLifeTime: TimeInterval = 60 * 60
        var networkRetryCount = 2
    }
    let config: DataStoreConfig
    let downloader: Downloader
    let databaseStack: DatabaseStack
    let userDefaults: UserDefaults
}

final class DataStoreImpl: DataStore {
    
    var params: DataStoreParams
    
    let eventsSubject = CurrentValueSubject<[EventCellViewModel], Error>([])
    var cancellable: AnyCancellable?
    
    var contentLoadedDate: Date? {
        get {
            params.userDefaults.value(forKey: "contentLoadedDate") as? Date
        }
        set {
            params.userDefaults.set(newValue, forKey: "contentLoadedDate")
        }
    }
    
    init(params: DataStoreParams) {
        self.params = params
    }
    
    func refreshEventsIfNeed() {
        if let date = contentLoadedDate, date.timeIntervalSince(Date()) < params.config.cacheLifeTime { return }
        
        cancellable = params.downloader.loadEvents(retryCount: params.config.networkRetryCount)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint("loading failed \(error)")
                case .finished:
                    debugPrint("loading comlited")
                }
            }, receiveValue: { [weak self] (model) in
                self?.save(loadedEvents: model.events.event)
            })
    }
    
    private func save(loadedEvents: [EventModel]) {
        let context = params.databaseStack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            let results = try context.fetch(fetchRequest) as? [Event]
            for loadedEvent in loadedEvents {
                let saved = results?.filter({ (event) -> Bool in
                    event.id == loadedEvent.id
                }).first
                if let saved = saved {
                    saved.update(model: loadedEvent)
                } else {
                    let newEvent = Event(context: context)
                    newEvent.update(model: loadedEvent)
                }
            }
            
        } catch {
            debugPrint("Fetch Failed: \(error)")
            assertionFailure()
        }

        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Saving Core Data Failed: \(error)")
            assertionFailure()
        }
    }
}
