//
//  PodcastsTableViewController.swift
//  podcast
//
//  Created by David Faliskie on 7/9/18.
//  Copyright © 2018 David Faliskie. All rights reserved.
//

import UIKit

class PodcastsTableViewController: UITableViewController {

    var podcasts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        podcasts = ["Episode 1", "Episode 2", "Episode 3"]
        
        self.tableView.register(PodcastTableViewCell.self, forCellReuseIdentifier: "podcastTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastTableViewCell") as! PodcastTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
