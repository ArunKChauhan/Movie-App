
//  Constants.swift



import Foundation

var posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "w1280", "original"]
var trailerQualitySettings: [String] = []
var person_id: Int?

struct Api {
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let KEY = "4524dbe1cb31c1afbf85b85e0f8963c2"
    static let SCHEME = "https"
    static let HOST = "api.themoviedb.org"
    static let PATH = "/3"
    
    
    
}

struct ParameterKeys {
    static let API_KEY = "api_key"
    static let PAGE = "page"
    static let TOTAL_RESULTS = "total_results"
    static let REGION = "region"
    static let MOVIE_ID = "movie_id"
}

struct ImageKeys {
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    struct PosterSizes {
        
        static let BACK_DROP = posterSizes[6]
        static let ROW_POSTER = posterSizes[2]
        static let DETAIL_POSTER = posterSizes[3]
        static let ORIGINAL_POSTER = posterSizes[6]
    }
}

struct Methods {
    
    static let NOW_PLAYING = "/movie/now_playing"
    static let TRENDING_WEEK = "/trending/movie/week"
    static let UPCOMING = "/movie/upcoming"
    static let TOP_RATED = "/movie/top_rated"
    static let POPULAR_ACTORS = "/person/popular"
    static let TRENDING_TV = "/trending/tv/week"
    
}


