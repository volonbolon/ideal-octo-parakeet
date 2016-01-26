//
//  MovieInfoViewController.swift
//  IdealOctoParakeet
//
//  Created by Ariel Rodriguez on 1/26/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var summaryTextView: UITextView!
    var movie:[String:AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.movie["title"] as? String
        self.summaryTextView.text = self.movie["summary"] as! String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == Constants.SegueIdentifier.ShowCast {
            let dvc = segue.destinationViewController as! CastTableViewController
            dvc.cast = self.movie["cast"] as! [String]
        }
    }
}
