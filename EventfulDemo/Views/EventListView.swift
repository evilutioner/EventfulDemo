//
//  EventListView.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/2/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import SwiftUI

struct EventListView: View {
    private let fetchRequest: FetchRequest<Event>
    private var events: FetchedResults<Event> { fetchRequest.wrappedValue }
    
    init(predicate: NSPredicate) {
        
        fetchRequest = FetchRequest(entity: Event.entity(), sortDescriptors: [], predicate: predicate)
    }
    
    var body: some View {
        List {
            ForEach(events) { event in
                EventCellView(event: event)
            }
        }
    }
}

