//
//  DetailViewController.swift
//  tz-rss-news
//
//  Created by Mac on 13.08.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    var postTitle: String?
    var postDate: String?
    var postDescription: String?
    var postImageString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postTitleLabel.text = postTitle
        postDateLabel.text = postDate
        if postImageString != "" {
            let url = URL(string: postImageString!)!
            let imageData = try! Data(contentsOf: url)
            postImageView.image = UIImage(data: imageData)
        } else {
            postImageView.removeFromSuperview()
            postDescriptionLabel.topAnchor.constraint(equalTo: postDateLabel.bottomAnchor).isActive = true
        }
        postDescriptionLabel.text = postDescription
    }
}
