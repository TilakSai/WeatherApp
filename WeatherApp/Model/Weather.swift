//
//  Weather.swift
//  WeatherApp
//
//  Created by Tilak on 8/29/24.
//

import Foundation
import Foundation

struct WeatherResponse: Decodable {
    let coord: Coordinates?
    let weather: [WeatherCondition]
    let main: MainWeather
    let wind: Wind?
    let clouds: Clouds?
    let sys: SystemInfo?
    let name: String
}

struct Coordinates: Decodable {
    let lon: Double
    let lat: Double
}

struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainWeather: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Clouds: Decodable {
    let all: Int
}

struct SystemInfo: Decodable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
