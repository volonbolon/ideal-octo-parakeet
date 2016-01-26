//
//  AuthorViewController.swift
//  IdealOctoParakeet
//
//  Created by Ariel Rodriguez on 1/26/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController {
    var authorInfo:[String:AnyObject]!
    
    @IBOutlet weak var bioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.authorInfo["name"] as? String
        self.bioTextView.text = self.authorInfo["bio"] as! String

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
