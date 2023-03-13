//
//  PhotoRO.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 09.03.2023.
//

import Foundation
import DeepDiff

// MARK: - Welcome
struct SearchResults: Codable {
    let total, totalPages: Int
    let results: [Photo]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: -
struct Photo: Codable, DiffAware {
    
    let id: String
    let createdAt, updatedAt: String
    let width, height: Int
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height
        case urls
    }
}

extension Photo: Equatable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
    }
    
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
