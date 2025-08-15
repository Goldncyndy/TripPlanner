//
//  APIClients.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import Foundation

class APIClient {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCities(completion: @escaping (Result<[City], NetworkError>) -> Void) {
        networkService.request(APIEndpoints.Cities.getCities,
                               method: "GET",
                               body: nil,
                               completion: completion)
    }
    
    func createTrip(_ trip: Trip, completion: @escaping (Result<Trip, NetworkError>) -> Void) {
        do {
            let body = try JSONEncoder().encode(trip)
            networkService.request(APIEndpoints.Trips.createTrip,
                                   method: "POST",
                                   body: body,
                                   completion: completion)
        } catch {
            completion(.failure(.requestFailed))
        }
    }
    
    func getTrips(completion: @escaping (Result<[Trip], NetworkError>) -> Void) {
        networkService.request(APIEndpoints.Trips.getTrips,
                               method: "GET",
                               body: nil,
                               completion: completion)
    }
}

