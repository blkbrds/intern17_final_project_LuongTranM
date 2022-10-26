//
//  WeatherResponse.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import UIKit
import CoreLocation

struct WeatherResponse: Codable {

    let main: Main
    let cityName: String

    enum CodingKeys: String, CodingKey {
        case main
        case cityName = "name"
    }

    init(main: Main,
         cityName: String) {
        self.main = main
        self.cityName = cityName
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        // City name
        cityName = try values.decode(String.self, forKey: .cityName)
        // Main
        let main = try values.decode(Main.self, forKey: .main)
        self.main = Main(temp: main.temp, humidity: main.humidity)
    }
}

struct Main: Codable {
    let temp: Float
    let humidity: Int
}
