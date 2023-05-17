//
//  NetworkConstants.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation

struct API {
    private struct ProductionServer {
        static let URLbase = "https://newsapi.org/v2/"
        static let ApiKey = "0e2f4d743f864265b2a67b78505c6ba2"
    }
    
    struct Keys {
        
        struct Home {
            static let articleData = "\(API.ProductionServer.URLbase)top-headlines?country=us&apiKey=\(API.ProductionServer.ApiKey)"
        }
    }
}
