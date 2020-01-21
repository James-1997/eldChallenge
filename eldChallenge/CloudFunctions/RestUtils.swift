//
//  RestUtils.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import UIKit

class RestUtils {
  static var baseUrl: String = "https://jsonplaceholder.typicode.com"
  
  enum OperationClient: String {
    case photos
    
    var url: String {
      switch self {
        case .photos:
          return "\(RestUtils.baseUrl)/photos"
      }
    }
  }
  
  enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
  }
  
  static public func postTo(url: URL, body: Data?, completionHandler: ((_ data: Data?, _ error: Error?) -> Void)?) {
    self.makeRequest(url: url, method: .post, body: body, completionHandler: completionHandler)
  }
  
  static public func getFrom(url: URL, completionHandler: ((_ data: Data?, _ error: Error?) -> Void)?) {
    self.makeRequest(url: url, method: .get, body: nil, completionHandler: completionHandler)
  }
  
  static public func putTo(url: URL, body: Data?, completionHandler:((_ data: Data?, _ error: Error?) -> Void)?) {
    self.makeRequest(url: url, method: .put, body: body, completionHandler: completionHandler)
  }
  
  static private func makeRequest(url: URL,
                                  method: HttpMethods,
                                  body: Data?,
                                  completionHandler: ((_ data: Data?, _ error: Error?) -> Void)?) {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, err) in
      if let _ = err {
        completionHandler?(data, err)
      } else {
        completionHandler?(data, nil)
      }
    }.resume()
  }
  
  static public func getPhotos(completionHandler: @escaping ((_ data: [Photo]?, _ error: Error?) -> Void)) {
    let operation: OperationClient = .photos
    guard let url = URL(string: operation.url) else {
      print("URL error: Bad formatter")
      return completionHandler(nil, nil)
    }
    self.getFrom(url: url) { (data, error) in
      if let data = data {
        do {
          let photos = try JSONDecoder().decode([Photo].self, from: data)
          completionHandler(photos, nil)
        } catch let jsonError {
          print("Error: \(jsonError.localizedDescription)")
          completionHandler(nil, jsonError)
        }
      } else if let error = error {
        print("Error: \(error.localizedDescription)")
        completionHandler(nil, error)
      }
    }
  }
}
