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
    // Variables
    var rowSelected : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: Constants.url)
       let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
           
        print(url)
    }
    override func viewDidLayoutSubviews() {
        webView.frame = view.bounds
    }
}
