//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Tilak on 8/29/24.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var searchText: String = ""
    @State private var showingAlert = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
        
                    HStack {
                        TextField("Enter city name", text: $searchText)
                            .padding(.horizontal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            searchForCity()
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                        .padding(.horizontal)
                    }
                    .padding()

        
                    Text(viewModel.locationName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    if let icon = viewModel.icon {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.top, 20)
                    }
                    
                    
                    Text(viewModel.temperature)
                        .font(.system(size: 72))
                        .bold()
                        .padding(.top, 20)
                    
                    
                    Text(viewModel.condition)
                        .font(.title)
                        .padding(.top, 10)
                    
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Min Temp: \(viewModel.minTemperature)")
                            Text("Max Temp: \(viewModel.maxTemperature)")
                            Text("Humidity: \(viewModel.humidity)%")
                            Text("Pressure: \(viewModel.pressure) hPa")
                        }
                        .padding()
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Wind Speed: \(viewModel.windSpeed) m/s")
                            Text("Wind Direction: \(viewModel.windDirection)°")
                            Text("Cloudiness: \(viewModel.cloudiness)%")
                            Text("Sunrise: \(viewModel.sunrise)")
                            Text("Sunset: \(viewModel.sunset)")
                        }
                        .padding()
                    }
                    .font(.footnote)
                    .padding(.bottom, 20)
                }
                .padding()
                .foregroundColor(.white)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("Unable to find the city"), dismissButton: .default(Text("OK")))
            }
            }
        }
        .onAppear {
            viewModel.fetchWeather(latitude: 33.0511, longitude: -96.9199)
        }
    }

    
    private func searchForCity() {
        guard !searchText.isEmpty else {
            showingAlert = true
            return
        }

        WeatherService.shared.fetchWeather(cityName: searchText) { weatherResponse in
            DispatchQueue.main.async {
                if let weather = weatherResponse {
                    viewModel.updateWeatherData(weather)
                } else {
                    showingAlert = true
                }
            }
        }
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel())
}
