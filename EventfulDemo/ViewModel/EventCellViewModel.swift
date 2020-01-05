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
    var isFavorite: Bool { get }
}

struct EventCellViewModel: EventCellViewModelProtocol {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .gregorian)
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm"
        return dateFormatter
    }()
    
    var name: String
    var dateString: String = ""
    var isFavorite: Bool
    
    init(name: String, dateString: String, isFavorite: Bool) {
        self.name = name
        self.dateString = dateString
        self.isFavorite = isFavorite
    }
    
    init(event: Event) {
        self.name = event.name ?? ""
        self.isFavorite = event.isFavorite
        if let startTime = event.startTime {
            self.dateString = Self.dateFormatter.string(from: startTime)
        }
    }
}
