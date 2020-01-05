//
//  EventModel.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/2/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//
import Foundation

struct EventModel: Decodable, Identifiable {
    var id: String
    var name: String
    var startTime: Date?
    var url: URL?
    
    static let formatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case startTime = "start_time"
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(URL.self, forKey: .url)
        
        let dateString = try container.decode(String.self, forKey: .startTime)
        if let date = Self.formatter.date(from: dateString) {
            startTime = date
        }
    }
}

