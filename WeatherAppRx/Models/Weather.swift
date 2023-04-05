//
//  Weather.swift
//  WeatherAppRx
//
//  Created by 권승용 on 2023/03/17.
//

import UIKit
import MapKit

struct Weather: Decodable {
    let cityName: String
    let temperature: Int
    let humidity: Int
    var iconName: String = ""
    let coordinate: CLLocationCoordinate2D
    
    static let empty = Weather(
        cityName: "",
        temperature: 0,
        humidity: 0,
        iconName: "exclamationmark.triangle.fill",
        coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)
    )
    
    init(cityName: String,
         temperature: Int,
         humidity: Int,
         iconName: String = "",
         coordinate: CLLocationCoordinate2D) {
        self.cityName = cityName
        self.temperature = temperature
        self.humidity = humidity
        self.iconName = iconName
        self.coordinate = coordinate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try values.decode(String.self, forKey: .cityName)
        let coordinate = try values.decode(Coordinate.self, forKey: .coordinate)
        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
        
        let mainInfo = try values.nestedContainer(keyedBy: MainInfoKeys.self, forKey: .main)
        temperature = Int(try mainInfo.decode(Double.self, forKey: .temp))
        humidity = try mainInfo.decode(Int.self, forKey: .humidity)
    }
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case main
        case weather
        case coordinate = "coord"
    }
    
    enum MainInfoKeys: String, CodingKey {
        case temp
        case humidity
    }
    
    private struct AdditionalInfo: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    private struct Coordinate: Decodable {
        let lat: CLLocationDegrees
        let lon: CLLocationDegrees
    }
}
