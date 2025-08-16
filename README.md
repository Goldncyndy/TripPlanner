
# Trip Planner iOS App

## Overview

This is a simple iOS application built with Swift, following an MVVM architecture, that allows users to create and view trips. The app consumes a REST API to store and retrieve trip data.

Key features:

* Create a new trip with details such as destination city, start date, end date, travel style, and notes.
* View a list of created trips.
* Store selected city and dates locally using UserDefaults for seamless data flow across screens.


## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/goldncyndy/trip-planner-ios.git
cd trip-planner-ios
```

### 2. Open the Project

* Open `TripPlanner.xcodeproj` in Xcode (tested on Xcode 13+).

### 3. Install Dependencies

* This project does not use any external dependencies. If you plan to add packages (like Alamofire), use Swift Package Manager via Xcode.

### 4. Build and Run

* Select the target simulator or device.
* Press `Cmd + R` to build and run the application.


## API Endpoints

The app uses a mock API created with Beeceptor for CRUD operations. All endpoints are listed in `APIEndpoints.swift`.

| Endpoint        | Method | Description                                                  |
| --------------- | ------ | ------------------------------------------------------------ |
| `/trips/create` | POST   | Create a new trip. Accepts a JSON payload with trip details. |
| `/trips`        | GET    | Fetch all trips. Returns an array of trip objects.           |
| `/cities`       | GET    | (Optional) Fetch the list of supported cities.               |

### Example Request: Create Trip

```json
POST https://trip-crud-api.free.beeceptor.com/trips/create
Content-Type: application/json

{
  "title": "Trip to Lagos",
  "destinationCity": { "city": "Lagos, Nigeria" },
  "startDate": "2025-08-20",
  "endDate": "2025-08-25",
  "notes": "Vacation with friends",
  "travelStyle": "Single"
}
```

### Example Response: Fetch Trips

```json
[
  {
    "id": "1",
    "title": "Trip to Lagos",
    "destinationCity": { "city": "Lagos, Nigeria" },
    "startDate": "2025-08-20",
    "endDate": "2025-08-25",
    "notes": "Vacation with friends",
    "travelStyle": "Single"
  }
]
```

## Project Structure (MVVM)

```
TripPlanner/
├── Models/
│   ├── Trip.swift
│   └── City.swift
├── ViewModels/
│   └── TripViewModel.swift
├── Views/
│   ├── CreateTripViewController.swift
│   └── SelectCityViewController.swift
├── Services/
│   └── NetworkService.swift
├── Resources/
│   └── Assets.xcassets
├── APIEndpoints.swift
└── README.md
```

## Additional Information

* Dates are handled using `DateFormatter` to convert between `String` and `Date` objects.
* The table views for cities and travel styles are dynamically populated.


This README gives enough information to run, test, and understand the project and API usage.


