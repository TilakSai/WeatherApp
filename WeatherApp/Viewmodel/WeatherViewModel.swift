//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Tilak on 8/29/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = "--"
    @Published var minTemperature: String = "--"
    @Published var maxTemperature: String = "--"
    @Published var humidity: String = "--"
    @Published var pressure: String = "--"
    @Published var windSpeed: String = "--"
    @Published var windDirection: String = "--"
    @Published var cloudiness: String = "--"
    @Published var sunrise: String = "--"
    @Published var sunset: String = "--"
    @Published var condition: String = "Unknown"
    @Published var icon: String?
    @Published var locationName: String = "Loading..."
    
    private let weatherService: WeatherService
    
    init(weatherService: WeatherService = WeatherService.shared) {
        self.weatherService = weatherService
    }
    
    func updateWeatherData(_ weather: WeatherResponse) {
        DispatchQueue.main.async {
            self.locationName = weather.name
            self.temperature = "\(weather.main.temp)°"
            self.minTemperature = "\(weather.main.temp_min)°"
            self.maxTemperature = "\(weather.main.temp_max)°"
            self.humidity = "\(weather.main.humidity)"
            self.pressure = "\(weather.main.pressure)"
            self.windSpeed = "\(weather.wind?.speed ?? 0.0)"
            self.windDirection = "\(weather.wind?.deg ?? 0)"
            self.cloudiness = "\(weather.clouds?.all ?? 0)"
            self.sunrise = self.formatTime(weather.sys?.sunrise ?? 0)
            self.sunset = self.formatTime(weather.sys?.sunset ?? 0)
            self.condition = weather.weather.first?.main ?? "Unknown"
            self.icon = self.getIconName(for: weather.weather.first?.icon ?? "")
        }
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        weatherService.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] weatherResponse in
            DispatchQueue.main.async {
                guard let weather = weatherResponse else { return }
                self?.updateWeatherData(weather)
            }
        }
    }
    
    private func getIconName(for icon: String) -> String {
        switch icon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d", "02n": return "cloud.sun.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "cloud.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d", "11n": return "cloud.bolt.fill"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "questionmark"
        }
    }
    
    private func formatTime(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}


