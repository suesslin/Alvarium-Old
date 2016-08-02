//
//  Network.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import Foundation

class Network {
  let URL: Foundation.URL
  lazy var session = URLSession.shared()
  
  typealias completion = (([String: AnyObject]?) -> Void)
  
  init(url: Foundation.URL) {
    URL = url
  }
  
  func requestDownload(_ theCompletion: completion) {
    let request = URLRequest(url: URL)
    let task = session.dataTask(with: request) {
      (data, response, error) in
      
      if let httpResponse = response as? HTTPURLResponse {
        switch httpResponse.statusCode {
        case 200:
          print("Succes")
          let jsonDictionary = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String: AnyObject]
          theCompletion(jsonDictionary)
        default: print("Error")
        }
      } else {
        print("Error")
        
      }
    }
    
    task.resume()
  }
}

