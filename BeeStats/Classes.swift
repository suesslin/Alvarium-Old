//
//  Classes.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import Foundation

struct Stat {
  var key: String
  var value: Int
}

struct GameMode {
  var fullName: String
  var acronym: String
  var stats: [Stat]
}

struct Player {
  var username: String = ""
  var rankName: String = ""
  var tokens: Int = 0
  var uuid: String = ""
  var firstLogin: Int = 0
  var lastLogin: Int = 0
  var lastLogout: Int = 0
  
  // Gamemodes
  
  var gameModes: [GameMode] = []
  
  init() {
  }
  
  init(dictionary: [String: AnyObject]?) {
    
    username = dictionary?["username"] as! String
    rankName = dictionary?["rankName"] as! String
    tokens = dictionary?["tokens"] as! Int
    uuid = dictionary?["UUID"] as! String
    firstLogin = dictionary?["firstLogin"] as! Int
    lastLogin = dictionary?["lastLogin"] as! Int
    lastLogout = dictionary?["lastLogout"] as! Int
    
    // Survival Games
    
    let sgDic = dictionary?["sg"] as! [String:AnyObject]
    
    gameModes.append(
      GameMode(fullName: "Survival Games", acronym: "SG", stats: [
      Stat(key: "Victories", value: sgDic["victories"] as! Int),
      Stat(key: "Kills", value: sgDic["kills"] as! Int),
      Stat(key: "Deaths", value: sgDic["deaths"] as! Int),
      Stat(key: "Deathmatches", value: sgDic["deathmatches"] as! Int),
      Stat(key: "Points", value: sgDic["points"] as! Int)
      ])
    )
    
  }
  
}