//
//  CreateTripViewModel.swift
//  TripPlanner
//
//  Created by Cynthia D'Phoenix on 8/15/25.
//

import Foundation

class TripViewModel {
    
    // MARK: - Properties
    private let networkService = NetworkService.shared
    
    var trips: [Trip] = [] {
        didSet {
            // You can notify the ViewController here if using bindings/closure
            self.onTripsUpdated?()
        }
    }
    
    var onTripsUpdated: (() -> Void)?       // Closure to notify ViewController
    
    // MARK: - Create Trip
    func createTrip(destination: String, startDate: String, endDate: String, travelName: String, description: String, travelStyle: String) {
        
        // Convert destination String back to City
        let city = City(city: destination)
        
        // Convert date Strings back to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let start = dateFormatter.date(from: startDate),
              let end = dateFormatter.date(from: endDate) else {
            print("Error: invalid date format")
            return
        }
        
        let newTrip = Trip(title: travelName, destinationCity: city, startDate: start, endDate: end, notes: description, travelStyle: travelStyle)
        
        networkService.createTrip(newTrip) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trip):
                    print("Trip created: \(trip)")
                    self?.trips.append(trip)
                case .failure(let error):
                    print("Error creating trip: \(error.localizedDescription)")
                }
            }
        }
    }
    
//    func createTrip(destination: City, startDate: Date, endDate: Date, travelName: String, description: String, travelStyle: String) {
//        let newTrip = Trip(title: travelName, destinationCity: destination, startDate: startDate, endDate: endDate, notes: description, travelStyle: travelStyle)
//        
//        networkService.createTrip(newTrip) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let trip):
//                    print("Trip created: \(trip)")
//                    self?.trips.append(trip)
//                case .failure(let error):
//                    print("Error creating trip: \(error.localizedDescription)")
//                }
//            }
//        }
//    }


    
    // MARK: - Fetch Trips
    func fetchTrips() {
        networkService.fetchTrips { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trips):
                    print("Fetched trips: \(trips)")
                    self?.trips = trips
                case .failure(let error):
                    print("Error fetching trips: \(error.localizedDescription)")
                }
            }
        }
    }
}
