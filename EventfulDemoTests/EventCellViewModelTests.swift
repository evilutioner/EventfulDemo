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

    //  TODO: The problem is that the App does not have the same namespace as when we are running the tests. <AppName>.<ClassName> vs <AppName>Tests.<ClassName>
    func _testInitMappingByEvent() {
        let event = Event.buildSample1(context: coreDataMock.mockPersistantContainer.viewContext)
        let viewModel = EventCellViewModel(event: event)
        XCTAssertEqual(event.isFavorite, viewModel.isFavorite)
        XCTAssertEqual(event.name, viewModel.name)
        XCTAssertEqual(event.url, viewModel.url?.absoluteString)
    }
    
    func testFormatter() {
        let formatter = EventCellViewModel.dateFormatter
        XCTAssertEqual(formatter.string(from: Date(timeIntervalSince1970: 1578583757)), "Thu, 09 Jan 2020 18:29")
        XCTAssertEqual(formatter.string(from: Date(timeIntervalSince1970: 1607810460)), "Sun, 13 Dec 2020 01:01")
        XCTAssertEqual(formatter.string(from: Date(timeIntervalSince1970: 1607774460)), "Sat, 12 Dec 2020 15:01")
        XCTAssertEqual(formatter.locale.calendar.identifier, Calendar.Identifier.gregorian)
    }
    
    func testInitMappingSample1() {
        mappingTest(name: "Book Discussion Group",
                    dateString: "Thu, 09 Jan 2020 18:29",
                    isFavorite: true,
                    url: "http://sandiego.eventful.com/venues/mysterious-galaxy-books-/V0-001-000104270-1")
    }
    
    func testInitMappingSample2() {
        mappingTest(name: "Book Discussion Group 2",
                    dateString: "Sat, 12 Dec 2020 15:01",
                    isFavorite: false,
                    url: "http://sandiego.eventful.com/venues/mysterious-galaxy-books-/V0-001-000104270-2")
    }
    
    func testInitMappingSample3() {
        mappingTest(name: "",
                    dateString: "",
                    isFavorite: false,
                    url: "")
    }
    
    private func mappingTest(name: String, dateString: String, isFavorite: Bool, url: String) {
        let url = URL(string: url)
        let viewModel = EventCellViewModel(name: name, dateString: dateString, isFavorite: isFavorite, url: url)
        XCTAssertEqual(name, viewModel.name)
        XCTAssertEqual(dateString, viewModel.dateString)
        XCTAssertEqual(isFavorite, viewModel.isFavorite)
        XCTAssertEqual(url, viewModel.url)
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
