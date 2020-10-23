//
//  Movie.swift


import Foundation


struct Movie: Codable {
    
    var profile_path: String?
    var poster_path: String?
    let title: String?
    let backdrop_path: String?
    
    let poster: String?
    let overview: String?
    let release_date: String?
    
    let video: Bool?
    var runtime: Int?
    
    let id: Int?
    let genre_ids: [Int]?
    let popularity: Double?
    var vote_average: Double?
    
    //TV
    let first_air_date: String?
    let name: String?
    var birthday: String?
}

