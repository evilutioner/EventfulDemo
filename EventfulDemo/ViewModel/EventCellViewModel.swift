//
//  EventCellViewModel.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/2/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import Foundation

protocol EventCellViewModelProtocol {
    var name: String { get }
    var dateString: String { get }
    var isFavorite: Bool { get set }
}

struct EventCellViewModel: EventCellViewModelProtocol {
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .gregorian)
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm"
        return dateFormatter
    }()
    
    let name: String
    let dateString: String
    var isFavorite: Bool {
        didSet {
            guard let event = event, let moc = event.managedObjectContext, !event.isDeleted  else { return }
            event.isFavorite = isFavorite
            try? moc.save()
            event.objectWillChange.send()
        }
    }
    var url: URL?
    
    private var event: Event?
    
    init(name: String, dateString: String, isFavorite: Bool, url: URL? = nil) {
        self.name = name
        self.dateString = dateString
        self.isFavorite = isFavorite
        self.url = url
    }
    
    init(event: Event) {
        self.event = event
        self.name = event.name ?? ""
        self.isFavorite = event.isFavorite
        if let startTime = event.startTime {
            self.dateString = Self.dateFormatter.string(from: startTime)
        } else {
            self.dateString = ""
        }
        if let path = event.url {
            self.url = URL(string: path)
        }
    }
}
