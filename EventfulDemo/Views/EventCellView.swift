//
//  EventCellView.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/2/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import SwiftUI

struct EventCellView: View {
    
    @State private var viewModel: EventCellViewModel
    @State private var showSafari = false
    
    init(viewModel: EventCellViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
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
                    .onTapGesture { self.viewModel.isFavorite = !self.viewModel.isFavorite }
            }
            .padding()
        }.sheet(isPresented: $showSafari) {
            SafariView(url: self.viewModel.url)
        }
    }
}


struct EventCellView_Previews: PreviewProvider {
    @State static var viewModel = EventCellViewModel(name: "Name", dateString: "Date", isFavorite: true)
    static var previews: some View {
        EventCellView(viewModel: viewModel)
    }
}
