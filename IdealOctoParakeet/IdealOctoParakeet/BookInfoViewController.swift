//
//  BookInfoViewController.swift
//  IdealOctoParakeet
//
//  Created by Ariel Rodriguez on 1/26/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController {

    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var bookInfo:[String:AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.text = self.bookInfo["summary"] as! String
        let author = self.bookInfo["author"] as! [String:AnyObject]
        
        self.authorButton.setTitle((author["name"] as! String), forState: UIControlState.Normal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == Constants.SegueIdentifier.ShowAuthorDetail {
            let dvc = segue.destinationViewController as! AuthorViewController
            dvc.authorInfo = self.bookInfo["author"] as! [String:AnyObject]
        }
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
