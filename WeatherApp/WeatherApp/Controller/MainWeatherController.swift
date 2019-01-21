//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainWeatherController: UIViewController {

  
  @IBOutlet weak var weatherDisplayColletionView: UICollectionView!
  
  @IBOutlet weak var cityName: UILabel!
  
  @IBOutlet weak var zipCodeField: UITextField!
  
  @IBOutlet weak var zipCodeMessage: UILabel!
  
  
  var arrayOfWeatherInfo = [WeatherDetails]() {
    didSet {
      DispatchQueue.main.async {
      self.weatherDisplayColletionView.reloadData()
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchWeatherForecast()
    weatherDisplayColletionView.dataSource = self
    
  }

  private func searchWeatherForecast(keyword: String = "11101"){
    WeatherAPIClient.searchWeather(keyword: keyword) { (appError, weather) in
      if let appError = appError {
       print(appError.errorMessage())
      } else if let weather = weather {
       print("found \(weather.count) podcast")
        dump(weather)
        self.arrayOfWeatherInfo = weather
      }
    }
  }
}

extension MainWeatherController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfWeatherInfo.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = weatherDisplayColletionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCollectionCell else {return UICollectionViewCell()}
    
    let currentDayWeather = arrayOfWeatherInfo[indexPath.row]
    
    
    
    return cell
  }
}


