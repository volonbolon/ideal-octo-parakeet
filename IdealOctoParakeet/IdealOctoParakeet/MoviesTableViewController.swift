//
//  MoviesTableViewController.swift
//  IdealOctoParakeet
//
//  Created by Ariel Rodriguez on 1/26/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    let movies:[[String:AnyObject]]
    
    required init?(coder aDecoder: NSCoder) {
        let bundle = NSBundle.mainBundle()
        let contentURL = bundle.URLForResource("content", withExtension: "plist")
        
        let content = NSDictionary(contentsOfURL: contentURL!)!
        self.movies = content.objectForKey("movies") as! [[String:AnyObject]]
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("moviesCell", forIndexPath: indexPath)

        let movie = self.movies[indexPath.row]
        
        cell.textLabel?.text = movie["title"] as? String

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == Constants.SegueIdentifier.ShowMovieDetail {
            let selectedIndexPath = self.tableView.indexPathForSelectedRow
            let movie = self.movies[selectedIndexPath!.row]
            let dvc = segue.destinationViewController as! MovieInfoViewController
            dvc.movie = movie
        }
    }

}
