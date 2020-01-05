//
//  Event+Ext.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/4/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//
import CoreData

extension Event: Identifiable {
    func update(model: EventModel) {
        id = model.id
        name = model.name
        startTime = model.startTime
        url = model.url?.absoluteString
    }
}

