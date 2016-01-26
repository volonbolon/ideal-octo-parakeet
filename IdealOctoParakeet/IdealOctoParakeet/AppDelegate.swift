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
        let selectedIndex = 1
        self.rootViewController.selectedIndex = selectedIndex
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nvc = self.rootViewController.viewControllers![selectedIndex] as! UINavigationController
        if let components = url.pathComponents {
            if components.count > 2 {
                let i = Int(components.last!)!
                let mtvc = nvc.viewControllers.first as! MoviesTableViewController
                let movies = mtvc.movies
                if movies.count > i {
                    let movie = movies[i]
                    let dvc = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.MovieInfoViewController) as! MovieInfoViewController
                    dvc.movie = movie
                    nvc.pushViewController(dvc, animated: false)
                    
                    let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
                    if let showCast = urlComponents!.paramWithName("showCast") {1
                        if showCast == "true" {
                            let cvc = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.CastTableViewController) as! CastTableViewController
                            cvc.cast = movie["cast"] as! [String]
                            nvc.pushViewController(cvc, animated: false)
                        }
                    }
                }
            }
        }
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
        return true
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if url.scheme == "parakeet" {
            self.deepLink(url)
            return true
        }
        return false
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
        
    }

}

