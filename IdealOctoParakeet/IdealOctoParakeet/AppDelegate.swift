//
//  AppDelegate.swift
//  IdealOctoParakeet
//
//  Created by Ariel Rodriguez on 1/26/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

extension NSURLComponents {
    func paramWithName(name:String)->String? {
        if let queryItems = self.queryItems {
            return queryItems.filter({$0.name == name}).first?.value
        }
        return nil
    }
}

class LinkHandler {
    // This is a oversimplification. In production code, we should introspect the controller
    let rootViewController:UITabBarController
    
    init(rootViewController:UITabBarController) {
        self.rootViewController = rootViewController
    }
}

extension LinkHandler {
    func handleBooks(url:NSURL) {
        self.rootViewController.selectedIndex = 0
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = self.rootViewController.viewControllers![0] as! UINavigationController
        if let components = url.pathComponents {
            if components.count > 2 {
                let i = Int(components.last!)!
                let btvc = nvc.viewControllers.first as! BooksTableViewController
                btvc.viewDidLoad()
                let books = btvc.books
                if books.count > i {
                    let book = books[i]
                    let dvc = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.BookInfoViewController) as! BookInfoViewController
                    dvc.bookInfo = book
                    nvc.pushViewController(dvc, animated: false)
                    
                    let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
                    if let showAuthor = urlComponents!.paramWithName("showAuthor") {1
                        if showAuthor == "true" {
                            let avc = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.AuthorViewController) as! AuthorViewController
                            avc.authorInfo = book["author"] as! [String:AnyObject]
                            nvc.pushViewController(avc, animated: false)
                        }
                    }
                }
            }
        }
    }
}

extension LinkHandler {
    func handleMovies(url:NSURL) {
        self.rootViewController.selectedIndex = 1
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nvc = self.rootViewController.viewControllers![0] as! UINavigationController
//        if let components = url.pathComponents {
//            if components.count > 2 {
//                let i = Int(components.last!)!
//                let btvc = nvc.viewControllers.first as! BooksTableViewController
//                btvc.viewDidLoad()
//                let books = btvc.books
//                if books.count > i {
//                    let book = books[i]
//                    let dvc = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.BookInfoViewController) as! BookInfoViewController
//                    dvc.bookInfo = book
//                    nvc.pushViewController(dvc, animated: false)
//                    
//                    let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
//                    if let showAuthor = urlComponents!.paramWithName("showAuthor") {1
//                        if showAuthor == "true" {
//                            let avc = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.AuthorViewController) as! AuthorViewController
//                            avc.authorInfo = book["author"] as! [String:AnyObject]
//                            nvc.pushViewController(avc, animated: false)
//                        }
//                    }
//                }
//            }
//        }
    }
}

enum TopDomains:String {
    case Books = "books"
    case Movies = "movies"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var linkHandler:LinkHandler!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.linkHandler = LinkHandler(rootViewController: self.window!.rootViewController as! UITabBarController)
        
        let url = NSURL(string: "fwk://deepLinkedContent/movies/1?showAuthor=true")
        self.deepLink(url!)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func deepLink(url:NSURL) {
        if let components = url.pathComponents {
            
            let td = TopDomains(rawValue: components[1])!
            switch td {
            case .Books:
                self.linkHandler.handleBooks(url)
            case .Movies:
                self.linkHandler.handleMovies(url)
            }
        }
        
        
//        print(components) // Optional(["/", "books", "1"])
//        print(url.path) // Optional("/books/1")
//        print(url.query) // Optional("showDetails=true")
        
    }

}

