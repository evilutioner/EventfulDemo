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
    @State private var isRefreshing = false
    @EnvironmentObject var dataStore: DataStore
    
    init(predicate: NSPredicate) {
        fetchRequest = FetchRequest(entity: Event.entity(), sortDescriptors: [], predicate: predicate)
    }
    
    var body: some View {
        List {
            ForEach(events) { event in
                EventCellView(event: event)
            }
        }
        .background(PullToRefresh(action: {
            self.dataStore.refreshEventsIfNeed(force: true) {
                self.isRefreshing = false
            }
        }, isShowing: $isRefreshing))
    }
}
