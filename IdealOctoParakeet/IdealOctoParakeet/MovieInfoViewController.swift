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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
