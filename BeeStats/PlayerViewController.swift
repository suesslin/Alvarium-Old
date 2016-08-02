//
//  PlayerViewController.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
  
  @IBOutlet weak var statTable: UITableView!
  var player = Player()
  var requestedUsername = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateUI()
    statTable.dataSource = self
  }
  
  
  func updateUI() {
    
    let parsing = DownloadUserProfile()
    parsing.downloadJSON(requestedUsername) { (player) in
      
      DispatchQueue.main.async {
        self.player = player!
        self.statTable.reloadData()
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
