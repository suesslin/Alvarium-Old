//
//  PlayerViewController.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
  
  var player = Player()

  override func viewDidLoad() {
    super.viewDidLoad()
    parsing()
  }
  
  func parsing() {
    let ply = DownloadUserProfile()
    ply.downloadJSON("OddDork") { (player) in
      print(player?.rankName)
      debugPrint(player)
    }
  }
}

