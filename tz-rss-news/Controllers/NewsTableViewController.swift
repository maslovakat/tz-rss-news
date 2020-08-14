//
//  NewsTableViewController.swift
//  tz-rss-news
//
//  Created by Mac on 13.08.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit


class NewsTableViewController: UITableViewController, NewsSubscriber {
    func accept(changed newsItems: [NewsItem]) {
        if newsItems.count == 0 {
            nothingWasFound()
        } else {
            self.tableView.reloadData()
        }
        
        self.spinner.removeFromSuperview()
    }
    
    var url: String?
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSpinner()
        NewsManager.shared.add(subscriber: self)
        NewsManager.shared.getNewsByLink(url: self.url!)
    }
    
    func showSpinner() {
        spinner.color = .darkGray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func nothingWasFound() {
        let alert = UIAlertController(title: "Nothing was found", message: "Try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsManager.shared.newsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        cell.titleLabel.text = NewsManager.shared.newsItems[indexPath.item].title
        cell.dateLabel.text = NewsManager.shared.newsItems[indexPath.item].pubDate
        cell.descriptionLabel.text = NewsManager.shared.newsItems[indexPath.item].description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailNewsSegue", sender: NewsManager.shared.newsItems[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newsItem = sender as! NewsItem
        if segue.identifier == "detailNewsSegue" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.postTitle = newsItem.title
            detailVC.postDescription = newsItem.description
            detailVC.postDate = newsItem.pubDate
            detailVC.postImageString = newsItem.image
        }
    }
}
