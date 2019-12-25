//
//  BookmarksTableViewController.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/24/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import UIKit

class BookmarksTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var newsPersister: NewsPersister!
    private var bookmarkedNews: [News] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bookmarks"
        newsPersister = NewsPersister()
        registerCell()
        getBookmarkedNews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBookmarks), name: NSNotification.Name(rawValue: "BookmarskUpdated"), object: nil)
    }
    
    // MARK: - Actions methods
    
    @objc func updateBookmarks() {
        getBookmarkedNews()
    }
    
    // MARK: - Private methods
    
    private func registerCell() {
        tableView.register(UINib(nibName: NewsTableViewCell.name, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.name)
    }
    
    private func getBookmarkedNews() {
        newsPersister.getBookmarkedNews { [weak self] (news) in
            self?.bookmarkedNews = news
        }
    }
    
    private func showDetails(for news: News) {
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: DetailsTableViewController.name) as? DetailsTableViewController else {
            fatalError()
        }
        detailsVC.news = news
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - UITableView methods

extension BookmarksTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.name, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        let newsObject = bookmarkedNews[indexPath.row]
        
        cell.starButtonAction = { (_) in
            // Star button is always selected because we are showing only bookmarked news here, and because of that there is no need to check state
            self.newsPersister.removeFromBookmarked(news: newsObject)
        }
        
        cell.populateData(with: newsObject)
        cell.starButton.isSelected = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(for: bookmarkedNews[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
