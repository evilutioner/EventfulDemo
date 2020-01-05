//
//  TabBarViewModel.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/3/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import CoreData

enum TabBarItem: Int, CaseIterable, Identifiable {
    
    case events = 0
    case favoriteEvents
    
    var id: String { "\(rawValue)" }
    
    var name: String {
        switch self {
        case .events: return "Events"
        case .favoriteEvents: return "Favorite"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .events: return "book"
        case .favoriteEvents: return "star"
        }
    }
    
    var predicate: NSPredicate {
        switch self {
        case .events: return NSPredicate(value: true)
        case .favoriteEvents: return NSPredicate(format: "isFavorite = YES")
        }
    }
}

protocol TabBarViewModelProtocol {
    var barItems: [TabBarItem] { get }
}

struct TabBarViewModel: TabBarViewModelProtocol {
    let barItems: [TabBarItem] = [.events, .favoriteEvents]
}
