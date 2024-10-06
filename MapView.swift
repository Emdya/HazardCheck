import SwiftUI
import MapKit

// Define the Coordinate structure
struct Coordinate: Codable, Identifiable {
    var id = UUID() // Unique identifier
    let latitude: Double
    let longitude: Double

    // Initialize with CLLocationCoordinate2D
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // Convert to CLLocationCoordinate2D
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// Define the Location structure
struct Location: Identifiable, Codable {
    let id = UUID() // Unique identifier
    let name: String
    let coordinate: Coordinate
    let crimeRate: Double
}

// SafetyAlgorithm class to generate suggestions
struct SafetyAlgorithm {
    func generateSuggestions(for averageCrimeRate: Double) -> [String] {
        var suggestions: [String] = []
        
        if averageCrimeRate > 0.5 {
            suggestions.append("Avoid walking alone at night.")
        }
        if averageCrimeRate > 1.0 {
            suggestions.append("Consider using rideshare services instead of walking.")
        }
        if averageCrimeRate > 1.5 {
            suggestions.append("Stay aware of your surroundings and avoid secluded areas.")
        }
        
        return suggestions
    }
}

// MapView structure
struct MapView: View {
    @State private var selectedLocation: Location?
    @State private var safetySuggestions: [String] = []

    // Hardcoded locations for demonstration
    let locations: [Location] = [
        Location(name: "Location A", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194), crimeRate: 0.6),
        Location(name: "Location B", coordinate: Coordinate(latitude: 37.7849, longitude: -122.4294), crimeRate: 1.2),
        Location(name: "Location C", coordinate: Coordinate(latitude: 37.7949, longitude: -122.4394), crimeRate: 1.8)
    ]

    var body: some View {
        VStack {
            // Create the MapView with a constant region and annotation items
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), latitudinalMeters: 1000, longitudinalMeters: 1000)),
                showsUserLocation: false,
                annotationItems: locations) { location in
                    // Create the map annotation for each location
                    MapAnnotation(coordinate: location.coordinate.toCLLocationCoordinate2D()) {
                        VStack {
                            Image(systemName: "mappin")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                            Text(location.name)
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                            selectedLocation = location
                            updateSuggestions(for: location)
                        }
                    }
                }
            .edgesIgnoringSafeArea(.all)

            // Display safety rate and suggestions
            if let selectedLocation = selectedLocation {
                VStack {
                    Text("Safety Rate for \(selectedLocation.name): \(selectedLocation.crimeRate)")
                        .font(.headline)
                        .padding()

                    List(safetySuggestions, id: \.self) { suggestion in
                        Text(suggestion)
                    }
                    .frame(maxHeight: 200)
                }
                .padding()
            } else {
                Text("Select a location on the map to see safety suggestions.")
                    .padding()
            }
        }
    }

    private func updateSuggestions(for location: Location) {
        let safetyAlgorithm = SafetyAlgorithm()
        safetySuggestions = safetyAlgorithm.generateSuggestions(for: location.crimeRate)
    }
}

// Preview for the MapView
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}




