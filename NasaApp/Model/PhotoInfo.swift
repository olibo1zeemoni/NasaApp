//
//  PhotoInfo.swift
//  NasaApp
//
//  Created by Olibo moni on 12/10/2025.
//


import Foundation
struct PhotoInfo: Codable, Identifiable {
    var id: URL { url }
    var title: String
    var copyright: String?
    var url: URL
    var description: String
    var date: String
    var isFavorite: Bool = false
    


    enum CodingKeys: String, CodingKey {
        case description = "explanation"
        case copyright
        case url
        case title
        case date
    }
    
}


enum PhotoInfoError: Error, LocalizedError {
    case invalidServerResponse
    case imageDataMissing
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .imageDataMissing:
            return "Could not decode image data."
        case .invalidURL:
            return "The URL provided was invalid."
        }
    }
}
