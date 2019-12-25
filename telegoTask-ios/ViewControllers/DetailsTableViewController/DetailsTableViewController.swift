//
//  DetailsTableViewController.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/24/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    // MARK: - Properties
    
    var news: News!

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        registerCell()
    }
    
    // MARK: - Private methods

    private func registerCell() {
        tableView.register(UINib(nibName: DetailsTableViewCell.name, bundle: nil), forCellReuseIdentifier: DetailsTableViewCell.name)
    }
}

// MARK: - UITableViewMethods

extension DetailsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.name, for: indexPath) as? DetailsTableViewCell else {
            fatalError()
        }
        
        cell.populateData(news: news)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
