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
       
        viewModel.$temp
           .sink(receiveValue: {[weak self] temp in
                      self?.temperatureLabel.text = temp})
           .store(in: &cancellable)
    }

     private var cancellable = Set<AnyCancellable>()
}
