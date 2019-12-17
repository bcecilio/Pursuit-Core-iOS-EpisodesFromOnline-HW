//
//  EpisodesController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allEpisodes: Show?
    var allShows: ShowData?
    
    var episodes = [EpisodeData](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getEpisodes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailController = segue.destination as? DetailController, let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        detailController.episodeDetail = episodes[indexPath.row]
    }
    
    func getEpisodes() {
        EpisodeAPI.fetchEpisodes(id: allEpisodes?.id ?? 1) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let episodes):
                self.episodes = episodes
            }
        }
    }
}

extension EpisodesController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodesCell else {
            fatalError("could not dequeue EpisodeCell")
        }
        let episodeCell = episodes[indexPath.row]
        cell.configureEpisodeCell(for: episodeCell)
        return cell
    }
}

extension EpisodesController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
