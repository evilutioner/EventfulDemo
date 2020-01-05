//
//  TabBarContentView.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/2/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import SwiftUI

struct TabBarContentView: View {
    @State var viewModel = TabBarViewModel()
    @State private var selection = 0
    
    let dataStore: DataStore
    //@EnvironmentObject var dataStore: DataStore
 
    var body: some View {
        TabView(selection: $selection){
            ForEach(viewModel.barItems) { barItem in
                EventListView(predicate: barItem.predicate)
                .tabItem {
                    VStack {
                        Image(systemName: barItem.systemImageName)
                        Text(barItem.name)
                    }
                }
                .tag(barItem.rawValue)
            }
        }.onAppear(perform: refreshEventsIfNeed)
    }
    
    private func refreshEventsIfNeed() {
        dataStore.refreshEventsIfNeed()
    }
}

//struct TabBarContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarContentView()
//    }
//}
