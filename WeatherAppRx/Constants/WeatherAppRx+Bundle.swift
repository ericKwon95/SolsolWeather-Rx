//
//  WeatherAppRx++Bundle.swift
//  WeatherAppRx
//
//  Created by 권승용 on 2023/03/06.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let weatherInfoPlist = self.path(forResource: "WeatherInfo", ofType: "plist") else { return "" }
       
        guard let resource = NSDictionary(contentsOfFile: weatherInfoPlist) else {
            return ""
        }
        guard let key = resource["API_KEY"] as? String else {
            fatalError("Create KeyInfo.plist and add your API Key.")
        }
        return key
    }
}
