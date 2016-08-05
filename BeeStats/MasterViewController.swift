//
//  MasterViewController.swift
//  BeeStats
//
//  Created by Lukas A. Müller on 01/08/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateUI()
    searchBar.delegate = self
    
  }
  
  func updateUI() {
    // SearchBar
    searchBar.placeholder = "Search for player"
    searchBar.barTintColor = UIColor.yellow()
    searchBar.keyboardType = .asciiCapable
    searchBar.keyboardAppearance = .dark
    
    //// Change TextField in Searchbar
    for subview in searchBar.subviews {
      for sub in subview.subviews {
        if let textfield = sub as? UITextField {
          textfield.backgroundColor = UIColor.clear()
          textfield.borderStyle = .none
        }
      }
    }
    
    updateNavigationBar(deviceSize: UIScreen.main().bounds)
  }
  
  func updateNavigationBar(deviceSize: CGRect) {
    
    //addLogo
    let logoImage = UIImage(named: "hiveLogo")
    let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40.5, height: 28))
    logoView.contentMode = .scaleAspectFit
    logoView.image = logoImage
    self.navigationItem.titleView = logoView
    
    
    // AddBackground
    switch deviceSize.width {
    case 320.0:
      print("640")
      setBarBackground(imageName: "640")
    case 375.0:
      print("750")
      setBarBackground(imageName: "750")
    case 414.0:
      print("1080")
      setBarBackground(imageName: "1080")
    default:
      print("Unkown device")
    }
  }
  
  func setBarBackground(imageName: String) {
    navigationController?.navigationBar.setBackgroundImage(UIImage(named: imageName), for: .default)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  // MARK: Segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "toPlayer" {
      let dc = segue.destinationViewController as! PlayerViewController
      dc.requestedPlayername = searchBar.text!
    }
  }
}

extension MasterViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    var containsInValidCharacter = false
    
    if searchBar.text?.characters.count != 0 {
      for letter in (searchBar.text?.characters)! {
        switch String(letter).uppercased() {
        case "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "_": print("Normal letter")
        default: searchRequestWrong(searchBar: searchBar)// Everything that is not allowed
        containsInValidCharacter = true
        }
      }
      if containsInValidCharacter != true {
        performSegue(withIdentifier: "toPlayer", sender: self)
      }
    }
    
  }
  
  func searchRequestWrong(searchBar: UISearchBar) {
    let controller = UIAlertController(title: "Search request contains invalid character", message: "A-Z, 0-9 and _ are allowed", preferredStyle: .alert)
    let actionOne = UIAlertAction(title: "Try again", style: .cancel) { (action) in
      searchBar.text = ""
      searchBar.becomeFirstResponder()
    }
    
    let actionTwo = UIAlertAction(title: "Cancel", style: .default) { (action) in
      searchBar.becomeFirstResponder()
    }
    controller.addAction(actionOne)
    controller.addAction(actionTwo)
    present(controller, animated: true, completion: nil)
  }
  
  
}
