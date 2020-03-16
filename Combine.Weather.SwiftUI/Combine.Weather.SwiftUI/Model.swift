//
//  Model.swift
//  Combine.Weather
//
//

import Foundation

// MARK: - WeatherDetail
struct WeatherDetail: Codable, Identifiable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: TimeInterval?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
    
    static var placeholder: Self {
        return WeatherDetail(coord: nil, weather: nil, base: nil, main: nil,
                           visibility: nil, wind: nil, clouds: nil, dt: nil,
                           sys: nil, id: nil, name: nil, cod: nil)
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let message: Double?
    let country: String?
    let sunrise, sunset: TimeInterval?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
