//
//  DataStore.swift
//  swift-github-repo-search-lab
//
//  Created by Jhantelle Belleza on 11/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class DataStore {
    static let sharedInstance = DataStore()
    var fullname = [String]()
    
    func getRepositories(completion: @escaping ()->()) {
        GithubAPIClient.getRepositories { repos in
            //            debugPrint("Datastore \(repos)")
            OperationQueue.main.addOperation {
                self.fullname = repos
                completion()
            }
        }
        
    }
    
    func searchRepositories(name: String, completion: @escaping () -> ()) {
        GithubAPIClient.searchRepositories(name: name) { (fullName) in
            OperationQueue.main.addOperation {
            self.fullname = fullName
            completion()
            }
        }
    }
    
}
