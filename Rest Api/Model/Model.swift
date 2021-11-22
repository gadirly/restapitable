//
//  Model.swift
//  Rest Api
//
//  Created by Babek Gadirli on 12.11.21.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}



struct Movie: Decodable {
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case overview = "overview"
    }
}
