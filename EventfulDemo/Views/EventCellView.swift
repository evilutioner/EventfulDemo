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
    //@Binding var viewModel: EventCellViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                Text(viewModel.dateString)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
        }
        .padding()
    }
}

//struct EventCellView_Previews: PreviewProvider {
//    @State static var viewModel = EventCellViewModel(name: "Name", dateString: "Date", isFavorite: true)
//    static var previews: some View {
//        EventCellView(viewModel: $viewModel)
//    }
//}
