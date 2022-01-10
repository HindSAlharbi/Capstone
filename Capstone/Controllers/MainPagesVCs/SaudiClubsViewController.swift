//
//  SaudiClubsViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/2/22.
//

import UIKit
import WebKit
import Firebase

class SaudiClubsViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      let url = URL(string: "http://sacmclubs.org")
       let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
           
        print(url)
    }
    override func viewDidLayoutSubviews() {
        webView.frame = view.bounds
    }

    
}
