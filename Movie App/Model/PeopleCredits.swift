//
//  PeopleCredits.swift



import Foundation

struct CastData:Codable {
    var poster_path:String?
    var id:Int?
}

struct CrewData:Codable {
    var poster_path:String?
    var id:Int?
}

struct PeopleCredits:Codable {
    var id: Int?
    var cast:[CastData]?
    var crew:[CrewData]?
}
