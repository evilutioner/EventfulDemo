//
//  Downloader.swift
//  EventfulDemo
//
//  Created by Oleg Marchik on 1/3/20.
//  Copyright © 2020 Oleg Marchik. All rights reserved.
//

import Foundation
import Combine

protocol Downloader {
    func loadEvents(retryCount: Int) -> AnyPublisher<EventsModel, Error>
}

final class DownloaderImpl: Downloader {
    static let session = URLSession(configuration: .default)
    
    var eventUrl: URL? {
        var urlComponents = URLComponents(string: "http://api.eventful.com/json/events/search")
        urlComponents?.queryItems = [URLQueryItem(name: "app_key", value: "CKKnt488bNT6HK2c"),
                                      URLQueryItem(name: "keywords", value: "books"),
                                      URLQueryItem(name: "location", value: "San+Diego"),
                                      URLQueryItem(name: "date", value: "San Future")]
        
        return urlComponents?.url
    }
    
    func loadEvents(retryCount: Int) -> AnyPublisher<EventsModel, Error> {
        guard let url = eventUrl else { return Fail<EventsModel, Error>(error: AppError.network("URL build error")).eraseToAnyPublisher() }
        return Self.session.dataTaskPublisher(for: url)
            .retry(retryCount)
            .map { $0.data }
            .decode(type: EventsModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
