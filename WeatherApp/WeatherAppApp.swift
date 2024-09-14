//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Tilak on 8/29/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel())
        }
    }
}
