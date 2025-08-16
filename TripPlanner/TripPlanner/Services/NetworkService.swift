//
//  NetworkService.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//


import Foundation


class NetworkService {
    
    static let shared = NetworkService()
    private let baseURL = "https://trip-crud-api.free.beeceptor.com"
    
    private init() {}
    
    // MARK: - Create Trip
    func createTrip(_ trip: Trip, completion: @escaping (Result<Trip, Error>) -> Void) {
        guard let url = URL(string: baseURL + APIEndpoints.createTrip) else {
            completion(.failure(NSError(domain: "", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Use ISO8601 for encoding dates
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            request.httpBody = try encoder.encode(trip)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // <-- Important
            
            do {
                let createdTrip = try decoder.decode(Trip.self, from: data)
                completion(.success(createdTrip))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Fetch Trips
    func fetchTrips(completion: @escaping (Result<[Trip], Error>) -> Void) {
        guard let url = URL(string: baseURL + APIEndpoints.getTrips) else {
            completion(.failure(NSError(domain: "", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // <-- Fixes your previous error
            
            do {
                let trips = try decoder.decode([Trip].self, from: data)
                completion(.success(trips))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
