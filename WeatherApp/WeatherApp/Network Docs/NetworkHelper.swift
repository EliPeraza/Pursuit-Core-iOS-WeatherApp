//
//  NetworkHelper.swift
//  WeatherApp
//
//  Created by Elizabeth Peraza  on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


/*https://pixabay.com/api/?key=11336119-d98b51ec1d5ebf172c2e75065&q=newyork
 https://pixabay.com/api/?key=(ENTER KEY HERE)&q=(PLACE NAME)
 */

public final class NetworkHelper {
  private init() {
    let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
    URLCache.shared =  cache
  }
  
  public static let shared = NetworkHelper()
  
  public func performDataTask(endpointURLString: String, httpMethod: String, httpBody: Data?, completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) -> Void){
    guard let url = URL(string: endpointURLString) else {
      completionHandler(AppError.badURL("\(endpointURLString)"), nil, nil)
      return
    }
    var request =  URLRequest(url: url)
    request.httpMethod = httpMethod
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        completionHandler(AppError.networkError(error), nil, response as? HTTPURLResponse)
        return
      } else if let data = data {
        completionHandler(nil, data, response as? HTTPURLResponse)
      }
    }
    task.resume()
  }
  
  public func performUploadTask(endpointURLString: String, httpMethod: String, httpBody: Data?, completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) -> Void) {
    guard let url = URL(string: endpointURLString) else {
      completionHandler(AppError.badURL("\(endpointURLString)"), nil, nil)
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.uploadTask(with: request, from: httpBody) { (data, response, error) in
      if let error = error {
        completionHandler(AppError.networkError(error), nil, response as? HTTPURLResponse)
        return
      } else if let data = data {
        completionHandler(nil, data, response as? HTTPURLResponse)
      }
    }
    task.resume()
  }
  
}
