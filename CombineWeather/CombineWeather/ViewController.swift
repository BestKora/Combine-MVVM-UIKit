//
//  ViewController.swift
//  Combine.Weather
//
//  Created by Ivan Sapozhnik on 11/3/19.
//  Copyright © 2019 Swifty Talks. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController{
     // MARK: - UI
    @IBOutlet weak var cityTextField: UITextField!{
        didSet {
            cityTextField.isEnabled = true
            cityTextField.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel!
     // MARK: - View Model
    private let viewModel = TempViewModel()
     
     // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.text = viewModel.city
        binding()
    }
    
     // MARK: - Combine
    func binding() {
        cityTextField.textPublisher
           .assign(to: \.city, on: viewModel)
           .store(in: &cancellable)
       
        viewModel.$currentWeather
           .sink(receiveValue: {[weak self] currentWeather in
            
            self?.temperatureLabel.text =
                currentWeather.main?.temp != nil ?
                "\(Int((currentWeather.main?.temp!)!)) ºC"
                : " "}
        )
           .store(in: &cancellable)
    }

     private var cancellable = Set<AnyCancellable>()
}

extension Date {
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var hourAndDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE hh a"
        return dateFormatter.string(from: self)
    }
    
    var hourOfTheDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self)
    }
    
    var timeOfTheDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}

extension DateFormatter {
    static var shared: DateFormatter = {
        return DateFormatter()
    }()
}
