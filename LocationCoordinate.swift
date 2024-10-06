import Foundation
import CoreLocation

struct Locationcoordinate: Codable {
    let latitude: Double
    let longitude: Double
    
    // Convert CLLocationCoordinate2D to Coordinate
    init(from location: CLLocationCoordinate2D) {
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
    
    // Convert Coordinate to CLLocationCoordinate2D
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}



