//
//  NetworkManager.swift
//  WeatherAppRx
//
//  Created by 권승용 on 2023/03/06.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit

class NetworkManager {
    // 싱글턴 패턴
    static let shared = NetworkManager()
    private init() {}
    
    let config = URLSessionConfiguration.default
    lazy var session = URLSession(configuration: config)
    
    // 날씨 데이터 Data 옵저버블로 변환
    private func getWeatherData(latitude lat: Double, longitude lon: Double) -> Observable<Data> {
        let APIKey = Bundle.main.apiKey
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lang=kr&units=metric&lat=\(lat)&lon=\(lon)&appid=\(APIKey)") else {
            fatalError("Error: url 생성 실패")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return session.rx.data(request: request)
    }
    
    // 좌표에 기반해 날씨 데이터를 가져오는 함수
    func getCurrentWeather(at coordinate: CLLocationCoordinate2D) -> Observable<Weather> {
        return getWeatherData(latitude: coordinate.latitude, longitude: coordinate.longitude)
            .map { data in
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Weather.self, from: data)
                return weather
            }
            .asObservable()
    }
    
}
