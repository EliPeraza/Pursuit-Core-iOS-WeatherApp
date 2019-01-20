//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
  let response: [WeatherInfo]
}

struct WeatherInfo: Codable {
  let periods: [WeatherDetails]
  let profile: CityName
}

struct WeatherDetails: Codable {
//  let timestamp: //timestamp
  let validTime: String
  let dateTimeISO: String
  let maxTempC: Int
  let maxTempF: Int
  let minTempC: Int
  let minTempF: Int
  let precipIN: Double
  let windSpeedKPH: Int
  let windSpeedMPH: Int
  let weather: String
//  let sunrise: //1547900135
  let sunriseISO: String
//  let sunset: //1547935089
  let sunsetISO: String
}

struct CityName: Codable {
  let tz: String
}

