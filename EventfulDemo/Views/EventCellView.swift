//
//  EventCellView.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/2/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import SwiftUI

struct EventCellView: View {
    let event: Event
    
    var viewModel: EventCellViewModel {
        EventCellViewModel(event: event)
    }
    @State private var showSafari = false
    
    var body: some View {
        Button(action: {
            self.showSafari = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.name)
                    Text(viewModel.dateString)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                    .onTapGesture(perform: tapOnfavoriteAction)
                
            }
            .padding()
        }.sheet(isPresented: $showSafari) {
            SafariView(url: self.event.url)
        }
    }
    
    private func tapOnfavoriteAction() {
        event.isFavorite = !event.isFavorite
    }
}

import CoreData

private extension NSManagedObject {
    var url: URL? {
        guard let path = value(forKey: "url") as? String else { return nil }
        return URL(string: path)
    }
}


//struct EventCellView_Previews: PreviewProvider {
//    @State static var viewModel = EventCellViewModel(name: "Name", dateString: "Date", isFavorite: true)
//    static var previews: some View {
//        EventCellView(viewModel: $viewModel)
//    }
//}
