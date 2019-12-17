//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showSearchBar: UISearchBar!
    
    var shows = [ShowData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        showSearchBar.delegate = self
        getShows(searchQuery: searchQuery)
        navigationItem.title = "Show Search"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeController = segue.destination as? EpisodesController, let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        episodeController.allShows = shows[indexPath.row]
    }
    
    func getShows(searchQuery: String) {
        ShowsSearchAPI.fetchShows(for: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let shows):
                self?.shows = shows
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowsCell else {
            fatalError("could not dequeue ShowCell!")
        }
        let showCell = shows[indexPath.row]
        cell.configureShowCell(for: showCell)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        getShows(searchQuery: searchText)
    }
}
