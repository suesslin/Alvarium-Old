//
//  WebViewController.swift
//  BeeStats
//
//  Created by Lukas Mueller on 8/6/16.
//  Copyright © 2016 Lukas Mueller. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
  
  @IBAction func cancelAction(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var webView: UIWebView!
    var urlString: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
      
      if urlString != nil {
        let url = URL(string: urlString!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
      } else {
        //dismiss
      }
    }
  

}
