//
//  API.swift
//  Combine.Weather
//
//  Created by Tatiana Kornilova on 06/03/2020.
//  Copyright © 2020 Swifty Talks. All rights reserved.
//

import Foundation
import Combine
import UIKit

class WeatherAPI {
    static let shared = WeatherAPI()
    
    private let baseaseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "cf0f31ab062ee5159fbd1c1c41a7057a"
    
    private func absoluteURL(city: String) -> URL? {
        let queryURL = URL(string: baseaseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil}
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    // Выборка детальной информации о погоде для города city без Generic "издателя"
       func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, Never> {
           guard let url = absoluteURL(city: city) else {                  // 1
               return Just(WeatherDetail.placeholder)
                   .eraseToAnyPublisher()
           }
           return
               URLSession.shared.dataTaskPublisher(for:url)                  // 2
                   .map { $0.data }                                          // 3
                   .decode(type: WeatherDetail.self, decoder: JSONDecoder()) // 4
                   .catch { error in Just(WeatherDetail.placeholder)}        // 5
                   .receive(on: RunLoop.main)                                // 6
                   .eraseToAnyPublisher()                                    // 7
       }
}

/*
 
 private let celsiusCharacters = "ºC"
 
 // Выборка температуры  без Generic "издателя"
 func fetchTemperature1(for city: String) -> AnyPublisher<String, Never> {
     guard let url = absoluteURL(city: city) else {
         return Just("0.0")
             .eraseToAnyPublisher()
     }
     return
         URLSession.shared.dataTaskPublisher(for:url)                  // 1
             .tryMap { data, response -> Data in
                 guard let httpResponse = response as? HTTPURLResponse,
                     httpResponse.statusCode == 200 else {
                         throw WeatherError.responseError
                 }
                 return data }                                         // 2
             .decode(type: WeatherDetail.self, decoder: JSONDecoder())
             .catch { error in Just(WeatherDetail.placeholder)}
             .map { $0.main?.temp ?? 0.0 }
             .map { "\($0) \(self.celsiusCharacters)" }
             .eraseToAnyPublisher()                                    // 7
 }
 
 // Асинхронная выборка на основе URL с сообщениями об ошибках
 func fetchErr<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
     URLSession.shared.dataTaskPublisher(for: url)                 // 1
         .tryMap { (data, response) -> Data in                     // 2
             guard let httpResponse = response as? HTTPURLResponse,
                 200...299 ~= httpResponse.statusCode else {
                     throw WeatherError.responseError
             }
             return data
     }
         .decode(type: T.self, decoder: JSONDecoder())             // 3
         .receive(on: RunLoop.main)                                // 4
         .eraseToAnyPublisher()                                    // 5
 }
 
 // Асинхронная выборка температуры
 func fetchTemperature1(for city: String) -> AnyPublisher<String, Never> {
     guard let url = absoluteURL(city: city) else {
         return Just("0.0")
             .eraseToAnyPublisher()
     }
     return fetchErr(url)
         .catch { error in Just(WeatherDetail.placeholder)}    // 1
         .map { (t: WeatherDetail) -> Double in                // 2
             return t.main?.temp ?? 0.0 }
         .map { "\($0) \(self.celsiusCharacters)" }          // 3
         .eraseToAnyPublisher()                              // 4
 }
 
 }
 enum WeatherError: Error {
     case responseError
 }
 */
