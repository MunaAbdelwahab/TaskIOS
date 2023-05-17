//
//  HomeVC+Model.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation

// MARK: - HomeDataResponse
struct HomeDataResponse: Codable {
    let totalResults: Int
    let status: String
    let articles: [ArticlesData]
    
    enum CodingKeys: String, CodingKey {
        case totalResults, status, articles
    }
}

// MARK: - ArticlesClass
struct ArticlesData: Codable {
    let source: Source
    let description: String
    let title: String
    let url: String
    let urlToImage: String
    let publishedAt: String
}

// MARK: - Source
struct Source: Codable {
    let id: String
    let name: String
}
