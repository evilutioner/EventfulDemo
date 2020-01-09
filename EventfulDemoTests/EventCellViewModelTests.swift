//
//  EventCellViewModelTests.swift
//  EventfulDemoTests
//
//  Created by Oleg Marchik on 1/8/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import XCTest
import CoreData
@testable import EventfulDemo

class EventCellViewModelTests: XCTestCase {
    
    let coreDataMock = CoreDataMock.shared

    //  TODO: the same issue as below
    func _tearDown() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Event.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        XCTAssertNoThrow(try coreDataMock.mockPersistantContainer.viewContext.execute(deleteRequest))
    }

    //  TODO: The problem is that the App does not have the same namespace as when you are running the tests. <AppName>.<ClassName> vs <AppName>Tests.<ClassName>
    func _testInitMappingByEvent() {
        let event = Event.buildSample1(context: coreDataMock.mockPersistantContainer.viewContext)
        let viewMode = EventCellViewModel(event: event)
        XCTAssertEqual(event.isFavorite, viewMode.isFavorite)
        XCTAssertEqual(event.name, viewMode.name)
        XCTAssertEqual(event.url, viewMode.url?.absoluteString)
    }
}

extension Event {
    static func buildSample1(context: NSManagedObjectContext) -> Event {
        let event = Event(context: context)
        event.id = "E0-001-128591811-5"
        event.isFavorite = true
        event.name = "Book Discussion Group"
        event.startTime = Date(timeIntervalSinceNow: 20500.0)
        event.url = "http://sandiego.eventful.com/venues/mysterious-galaxy-books-/V0-001-000104270-1?utm_source=apis&utm_medium=apim&utm_campaign=apic"
        return event
    }
}
