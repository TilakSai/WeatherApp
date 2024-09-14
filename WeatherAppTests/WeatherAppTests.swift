//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Tilak on 8/29/24.
//

import XCTest
@testable import WeatherApp

class MockWeatherService: WeatherService {
    var weatherResponse: WeatherResponse?
    
    override func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {
        completion(weatherResponse)
    }
}

final class WeatherAppTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    
    override func setUpWithError() throws {
        mockWeatherService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockWeatherService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockWeatherService = nil
    }
    
    func testWeatherDataParsing() throws {
        let mockResponse = WeatherResponse(
            coord: Coordinates(lon: -96.9199, lat: 33.0511),
            weather: [WeatherCondition(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")],
            main: MainWeather(temp: 32.97, feels_like: 37.43, temp_min: 31.92, temp_max: 34.29, pressure: 1013, humidity: 54),
            wind: Wind(speed: 4.12, deg: 90),
            clouds: Clouds(all: 75),
            sys: SystemInfo(type: 2, id: 2033903, country: "US", sunrise: 1725019280, sunset: 1725065723),
            name: "The Colony"
        )
        mockWeatherService.weatherResponse = mockResponse
        
        
        viewModel.fetchWeather(latitude: 33.0511, longitude: -96.9199)
        
        XCTAssertEqual(viewModel.locationName, "The Colony", "Expected location name to be The Colony")
        XCTAssertEqual(viewModel.temperature, "32.97°", "Expected temperature to be 32.97°")
        XCTAssertEqual(viewModel.condition, "Clouds", "Expected condition to be Clouds")
        XCTAssertEqual(viewModel.minTemperature, "31.92°", "Expected min temperature to be 31.92°")
        XCTAssertEqual(viewModel.maxTemperature, "34.29°", "Expected max temperature to be 34.29°")
        XCTAssertEqual(viewModel.humidity, "54", "Expected humidity to be 54%")
        XCTAssertEqual(viewModel.pressure, "1013", "Expected pressure to be 1013 hPa")
        XCTAssertEqual(viewModel.windSpeed, "4.12", "Expected wind speed to be 4.12 m/s")
        XCTAssertEqual(viewModel.windDirection, "90", "Expected wind direction to be 90°")
        XCTAssertEqual(viewModel.cloudiness, "75", "Expected cloudiness to be 75%")
    }
    
    func testWeatherDataFallbacks() throws {
        let mockResponse = WeatherResponse(
            coord: nil,
            weather: [],
            main: MainWeather(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 0, humidity: 0),
            wind: nil,
            clouds: nil,
            sys: nil,
            name: ""
        )
        mockWeatherService.weatherResponse = mockResponse
        
        viewModel.fetchWeather(latitude: 0, longitude: 0)
        
        XCTAssertEqual(viewModel.locationName, "", "Expected location name to be empty")
        XCTAssertEqual(viewModel.temperature, "0.0°", "Expected temperature to be 0.0°")
        XCTAssertEqual(viewModel.condition, "Unknown", "Expected condition to be Unknown")
        XCTAssertEqual(viewModel.icon, "questionmark", "Expected icon to be a question mark")
        XCTAssertEqual(viewModel.minTemperature, "0.0°", "Expected min temperature to be 0.0°")
        XCTAssertEqual(viewModel.maxTemperature, "0.0°", "Expected max temperature to be 0.0°")
        XCTAssertEqual(viewModel.humidity, "0", "Expected humidity to be 0%")
        XCTAssertEqual(viewModel.pressure, "0", "Expected pressure to be 0 hPa")
        XCTAssertEqual(viewModel.windSpeed, "0.0", "Expected wind speed to be 0.0 m/s")
        XCTAssertEqual(viewModel.windDirection, "0", "Expected wind direction to be 0°")
        XCTAssertEqual(viewModel.cloudiness, "0", "Expected cloudiness to be 0%")
    }
    
    func testPerformanceOfFetchWeather() throws {
        self.measure {
            viewModel.fetchWeather(latitude: 33.0511, longitude: -96.9199)
        }
    }
}
