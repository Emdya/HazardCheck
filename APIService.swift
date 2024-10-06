//
//  APIService.swift
//  HazardCheck5.0
//
//  Created by Emdya P on 10/6/24.
//


import Foundation
import CoreLocation

class APIService {
    let crimeApiKey = "YOUR_CRIME_API_KEY" // Replace with your actual API key
    
    func fetchNearbyLocations(for coordinate: CLLocationCoordinate2D, completion: @escaping ([Location]) -> Void) {
        // Construct URL for fetching nearby locations (simulated)
        let urlString = "https://api.crimeapi.com/nearby?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&key=\(crimeApiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let locations = try? JSONDecoder().decode([Location].self, from: data)
                DispatchQueue.main.async {
                    completion(locations ?? [])
                }
            } else {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
    
    func fetchCrimeData(for location: String, completion: @escaping (Double) -> Void) {
        // Simulate API call for crime data
        let urlString = "https://api.crimeapi.com/crime?location=\(location)&key=\(crimeApiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let crimeData = try? JSONDecoder().decode(CrimeData.self, from: data) {
                DispatchQueue.main.async {
                    completion(crimeData.crimeRate)
                }
            } else {
                DispatchQueue.main.async {
                    completion(0.0) // Return 0 if there's an error
                }
            }
        }.resume()
    }
}


struct CrimeData: Codable {
    let crimeRate: Double
}
