//
//  PlayerViewController.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
  
  @IBOutlet weak var statusLabel: UILabel!
  
  var player = Player() {
    
    // When player changes do this
    
    didSet {
      playernameLabel.text = player.username
      
      // When lastLogin is bigger than lastLogout it means that currently the user is logged in.
      if player.lastLogin > player.lastLogout {
        statusLabel.text = "Online"
      } else {
        statusLabel.text = "Offline"
      }
    }
  }
  @IBOutlet weak var statTable: UITableView!
  
  @IBOutlet weak var playernameLabel: UILabel!

  var requestedUsername = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    statTable.dataSource = self
    downloadTheShit()
  }
  
  func downloadTheShit() {
    let load = DownloadUserProfile()
    load.downloadJSON(requestedUsername) { (player) in
      DispatchQueue.main.async {
        self.player = player!
      }
    }
  }

  func updateOnlineStatus(online: Bool) {
    if online == true {
      updateLogoNavBar(name: "online")
    } else {
      updateLogoNavBar(name: "offline")
    }
  }
  
  func updateLogoNavBar(name: String) {
    let logoImage = UIImage(named: name)
    let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 41.5, height: 6.5))
    logoView.contentMode = .center
    logoView.image = logoImage
    self.navigationItem.titleView = logoView
  }
  
  // Right bar button item (= plus)
  func addToFavorite(_ sender: AnyObject) {
    
  }
}

extension PlayerViewController: UITableViewDataSource {
  
  // Return amount of sections in TableView
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return player.gameModes.count
  }
  
  // Return name for sections (= Gamemode names)
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return player.gameModes[section].fullName
  }
  
  // Return amount of rows in the section (= Amount of stats of gamemode)
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return player.gameModes[section].stats.count
  }
  
  // Return & edit the cell (= Change stat key, stat value and icon)
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = statTable.dequeueReusableCell(withIdentifier: "stat") as! StatTableViewCell
    
    // Editing the cell
    
    cell.keyLabel.text = player.gameModes[indexPath.section].stats[indexPath.row].key
    cell.valueLabel.text = String(player.gameModes[indexPath.section].stats[indexPath.row].value)
    
    return cell
  }
  
}
