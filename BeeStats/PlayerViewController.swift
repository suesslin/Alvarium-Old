//
//  PlayerViewController.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import UIKit
import CoreData

class PlayerViewController: UIViewController {
  
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var playerHeadImage: UIImageView!
  @IBOutlet weak var rankLabel: UILabel!
  @IBOutlet weak var tokensLabel: UILabel!
  @IBOutlet weak var statTable: UITableView!
  @IBOutlet weak var playernameLabel: UILabel!
  
  var requestedPlayername = ""
  var player = Player() {
    
    // DidSet excutes when data has been loaded and player overwritten
    
    didSet {
      if player.username != "" {
        playernameLabel.text = player.username
      
        statTable.reloadData()
      
        // When lastLogin is bigger than lastLogout it means that currently the user is logged in.
        if player.lastLogin > player.lastLogout {
          statusLabel.text = "Online"
        } else {
          statusLabel.text = "Offline"
        }
      
        tokensLabel.text = "\(player.tokens) Tokens"
        rankLabel.text = player.rankName
      } else {
        let alert = UIAlertController(title: "Requested playername, does not exist.", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Go Back", style: .default) { (action) in
          print("Go back!")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
      }
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statTable.dataSource = self
    
    updateUI()
  }
  

  func updateUI() {
    // Updates Username, stats, etc. via JSON
    downloadJson(playername: requestedPlayername)
    // Download player head profile picture
    downloadPlayerHead(playername: requestedPlayername)
  }
  
  func downloadPlayerHead(playername: String) {
    let url = URL(string: "https://avatar.hivemc.com/avatar/\(playername)/500")
    
    if let data = (try? Data(contentsOf: url!)) {
      let playerHead = UIImage(data: data)
      playerHeadImage.image = playerHead
    } else {
      // Show general profile picture
    }
  }
  
  func downloadJson(playername: String) {
    let load = DownloadUserProfile()
    load.downloadJson(playername) { (player) in
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
  
    // Action in the right corner of the navigation bar
  
    @IBAction func rightBarButtonAction(_ sender: UIBarButtonItem) {
        
        // Create Action sheet
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
        // Create Action for Copying UUID
      
        let actionOne = UIAlertAction(title: "Copy UUID", style: .default ) { (action) in
            // Copy UUID to clipboard
            let pasteBoard = UIPasteboard.general()
            pasteBoard.string = self.player.uuid
        }
        actionSheet.addAction(actionOne)
      
      let actionTwo = UIAlertAction(title: "Add to favorites", style: .default) { (action) in
      }
      
      actionSheet.addAction(actionTwo)
      
      let actionThree = UIAlertAction(title: "Open on HiveMC.com", style: .default) { (action) in
        self.performSegue(withIdentifier: "toWebViewController", sender: self)
      }
      
      actionSheet.addAction(actionThree)

      
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
      
      actionSheet.addAction(cancelAction)
      
        // Present the View Controller
        present(actionSheet, animated: true, completion: nil)
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "toWebViewController" {
      let nav = segue.destinationViewController as! UINavigationController
      let dest = nav.topViewController as! WebViewController
      dest.urlString = "https://hivemc.com/player/\(player.username)"
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
