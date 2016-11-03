//
//  GithubAPIClient.swift
//  swift-github-repo-search-lab
//
//  Created by Jhantelle Belleza on 11/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire

class GithubAPIClient {
    
    class func getRepositories(completion: @ escaping ([String]) ->Void) {
        //        GET /search/repositories
        let githubUrl = "\(Secrets.githubURL)repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
        
        //get repositories
        Alamofire.request(githubUrl).responseJSON { response in
            var fullnameArray = [String]()
            guard let result = response.result.value as? [[String:Any]] else { return }
            for fullname in result {
                fullnameArray.append(fullname["full_name"] as! String)
            }
            completion(fullnameArray)
            
        }
    }
    
    class func searchRepositories(name: String, completion: @escaping ([String])->()) {
        let searchURL = "\(Secrets.githubURL)search/repositories?q=\(name)&order=asc"
        var fullName = [String]()
        
        Alamofire.request(searchURL).responseJSON{ (responseJSON) in
            guard let result = responseJSON.result.value as? [String:Any] else { return }
            
            let items = result["items"] as! [[String: Any]]
            for item in items {
                fullName.append(item["full_name"] as! String)
            }
           completion(fullName) //get the names of the searched repos
        }
        
    }
}


