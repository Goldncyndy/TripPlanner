//
//  NetworkService.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//


import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private let baseURL = URL(string: "https://trip-crud-api.free.beeceptor.com")!

    private init() {}
    
    // MARK: - Create Trip
    func createTrip(_ trip: Trip, completion: @escaping (Result<Trip, Error>) -> Void) {

    // Combine baseURL and endpoint from APIEndpoints
        guard let url = URL(string: APIEndpoints.baseURL + APIEndpoints.createTrip) else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(trip)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let createdTrip = try JSONDecoder().decode(Trip.self, from: data)
                completion(.success(createdTrip))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - View Trips
    func fetchTrips(completion: @escaping (Result<[Trip], Error>) -> Void) {
        // Combine baseURL and endpoint from APIEndpoints
            guard let url = URL(string: APIEndpoints.baseURL + APIEndpoints.getTrips) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let trips = try JSONDecoder().decode([Trip].self, from: data)
                completion(.success(trips))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
