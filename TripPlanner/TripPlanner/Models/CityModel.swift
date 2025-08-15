//
//  CityModel.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import Foundation


struct City: Codable {
//    let id: String?     
    let city: String
    
    // CodingKeys to match API's JSON keys (if needed)
    enum CodingKeys: String, CodingKey {
//        case id
        case city
    }
}
