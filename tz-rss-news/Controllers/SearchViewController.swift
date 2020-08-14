//
//  SearchViewController.swift
//  tz-rss-news
//
//  Created by Mac on 14.08.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var rssSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let url = rssSearchBar.text {
            self.performSegue(withIdentifier: "newsTableSegue", sender: url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsTableSegue" {
            let newsVC = segue.destination as! NewsTableViewController
            newsVC.url = sender as? String
        }
    }
}
