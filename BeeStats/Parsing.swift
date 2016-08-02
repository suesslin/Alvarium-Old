//
//  Parsing.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import Foundation

struct DownloadUserProfile {
  
  var startingURL = URL(string: "https://old.hivemc.com/json/userprofile/")
  
  func downloadJSON(_ username: String, completion: ((Player?) -> Void)) {
    if let finalURL = URL(string: username, relativeTo: startingURL!) {
      let network = Network(url: finalURL)
      network.requestDownload {
        (dictionary) in
        
        let currentPlayer = self.currentPlayerDictionary(dictionary)
        completion(currentPlayer)
      }
    } else {
      print("Error creating final URL")
    }
  }
  
  func currentPlayerDictionary(_ jsonDictionary: [String: AnyObject]?) -> Player? {
    if let Dictionary = jsonDictionary as? [String: AnyObject]? {
      return Player(dictionary: Dictionary!)
    } else {
      print("JSON dictionary returned nil for currently key")
      return nil
    }
  }
}
