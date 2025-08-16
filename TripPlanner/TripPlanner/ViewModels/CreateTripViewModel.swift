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
            //notify the ViewController here
            self.onTripsUpdated?()
        }
    }
    
    var onTripsUpdated: (() -> Void)? // Closure to notify ViewController
    
    // this closure shows Snackbar messages
       var onMessage: ((String, Bool) -> Void)?  // Bool: true = success, false = failure
    
    func createTrip(destination: String, startDate: String, endDate: String, travelName: String, description: String, travelStyle: String) {
        
        // Convert destination String to City
        let city = City(city: destination)
        
        // Convert date Strings back to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let start = dateFormatter.date(from: startDate),
              let end = dateFormatter.date(from: endDate) else {
            print("Error: invalid date format")
            return
        }
        
        let newTrip = Trip(id: UUID().uuidString, title: travelName, destinationCity: city, startDate: start, endDate: end, notes: description, travelStyle: travelStyle)
        
        networkService.createTrip(newTrip) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Trip created: \(newTrip)")
                    self?.trips.append(newTrip)
                    self?.onMessage?("Trip created successfully!", true)
                case .failure(let error):
                    print("Error creating trip: \(error.localizedDescription)")
                    self?.onMessage?("Failed to create trip: \(error.localizedDescription)", false)
                }
            }
        }
    }

    
    // MARK: - Fetch Trips
    
    func fetchLocalTrips() {
        networkService.fetchTrips { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedTrips):
                    // Merge fetched trips with local ones that have unique IDs
                    var allTrips = fetchedTrips
                    let newLocalTrips = self?.trips.filter { local in
                        !fetchedTrips.contains(where: { $0.id == local.id })
                    } ?? []
                    allTrips.append(contentsOf: newLocalTrips)
                    
                    self?.trips = allTrips
                    self?.onMessage?("Trips fetched successfully!", true)
                    
                case .failure(let error):
                    self?.onMessage?("Failed to fetch trips: \(error.localizedDescription)", false)
                }
            }
        }
    }
    
    func fetchTrips() {
        networkService.fetchTrips { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trips):
                    print("Fetched trips: \(trips)")
                    self?.trips = trips
                    self?.onMessage?("Trips fetched successfully!", true)
                case .failure(let error):
                    print("Error fetching trips: \(error.localizedDescription)")
                    self?.onMessage?("Failed to fetch trips: \(error.localizedDescription)", false)
                }
            }
        }
    }

}
