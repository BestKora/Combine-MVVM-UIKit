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
    @Published var temp = ""
    
    init() {
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
                WeatherAPI.shared.fetchWeather(for: city)
              }
            .map { $0.main?.temp ?? 0.0 }
            .map { "\($0) ºC" }
            .assign(to: \.temp , on: self)
            .store(in: &self.cancellableSet)
   }
    
    private var cancellableSet: Set<AnyCancellable> = []
}

   

