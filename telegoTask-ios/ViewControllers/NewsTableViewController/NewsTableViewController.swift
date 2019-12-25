//
//  NewsTableViewController.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    // MARK: - Properties
    
    private var news: [News] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var bookmarkedNews = [News]()
    private var newsPersister: NewsPersister!

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        newsPersister = NewsPersister()
        self.title = "News"
        registerCell()
        getBookmarkedNews()
        getNews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBookmarks), name: NSNotification.Name(rawValue: "BookmarskUpdated"), object: nil)
    }
    
    // MARK: - Actions methods

    @objc func updateBookmarks() {
        getBookmarkedNews()
        getNews()
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

    private func getNews() {
        let newsRepository = NewsRepository.init(networkService: ApiManager.shared)
        newsRepository.loadFromAPI { [weak self] (news, errorMessage) in
            self?.news = news
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

extension NewsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.name, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        let newsObject = news[indexPath.row]
        
        cell.starButtonAction = { (isSelected) in
            isSelected ? self.newsPersister.addToBookmarked(news: newsObject) : self.newsPersister.removeFromBookmarked(news: newsObject)
            self.getBookmarkedNews()
        }
        
        cell.populateData(with: newsObject)
        cell.starButton.isSelected = bookmarkedNews.contains(where: { $0.slugName == newsObject.slugName })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(for: news[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
