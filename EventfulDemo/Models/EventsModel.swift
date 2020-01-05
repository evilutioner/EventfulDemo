
//
//  EventsModel.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/3/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import Foundation

struct EventsModel: Decodable {
    struct NestedEventModel: Decodable {
        var event: [EventModel]
    }
    var events: NestedEventModel
}

