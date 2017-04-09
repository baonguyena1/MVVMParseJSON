//
//  MovieFeedController.swift
//  MVVMJSONTutorial
//
//  Created by Bao Nguyen on 4/9/17.
//  Copyright © 2017 Bao Nguyen. All rights reserved.
//

import UIKit

class MovieFeedController: UITableViewController {
    
    private var movieArray = [Movie]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let service = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        getService(fromService: service)
    }
    
    private func getService<S: Getable>(fromService service: S) where S.T == Array<Movie?> {
        service.get { [weak self] (result) in
            switch result {
            case .error(let error):
                print(error)
            case .success(let movies):
                self?.movieArray = movies as! [Movie]
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellIdentifier(), for: indexPath) as! MovieCell

        return cell
    }
}
