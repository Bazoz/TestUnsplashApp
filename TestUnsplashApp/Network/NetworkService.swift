//
//  NetworkService.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}

protocol NetworkServiceProtocol {
    func fetchPhotos(page: Int) async throws -> [Photo]
    func searchPhotos(query: String, page: Int) async throws -> [Photo]
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://api.unsplash.com"
    private let accessKey = "4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"
    
    func fetchPhotos(page: Int) async throws -> [Photo] {
        let url = URL(string: "\(baseURL)/photos?page=\(page)&per_page=30")!
        print(url)
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailed
        }
        return try JSONDecoder().decode([Photo].self, from: data)
    }
    
    func searchPhotos(query: String, page: Int) async throws -> [Photo] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(baseURL)/search/photos?query=\(encodedQuery)&page=\(page)&per_page=30")!
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailed
        }
        let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
        return searchResults.results
    }
}
