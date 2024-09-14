//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Tilak on 8/29/24.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    private let apiKey = "ec75c71fb8d8fbac6e1a9144781d969f"
    
    
    func fetchWeather(cityName: String, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchWeather(cityName: String, countryCode: String, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName),\(countryCode)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchWeather(cityName: String, stateCode: String, countryCode: String, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName),\(stateCode),\(countryCode)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

