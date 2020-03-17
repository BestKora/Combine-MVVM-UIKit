//
//  MoviesViewModel.swift
//  CombineFetchAPI
//
//  Created by Tatiana Kornilova on 28/10/2019.
//

import Combine
import Foundation

final class TempViewModel: ObservableObject {
    // input
    @Published var city: String = "London"
    // output
    @Published var currentWeather = WeatherDetail.placeholder
    
    init() {
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
                WeatherAPI.shared.fetchWeather(for: city)
              }
            .assign(to: \.currentWeather , on: self)
            .store(in: &self.cancellableSet)
   }
    
    private var cancellableSet: Set<AnyCancellable> = []
}

   

