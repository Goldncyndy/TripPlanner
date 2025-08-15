//
//  TripModel.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import Foundation

struct Trip: Codable {
//    let id: String?    
    let title: String
    let destinationCity: City
    let startDate: Date
    let endDate: Date
    let notes: String?
    let travelStyle: String?
    
    enum CodingKeys: String, CodingKey {
//        case id
        case title
        case destinationCity
        case startDate
        case endDate
        case notes
        case travelStyle
    }
}

