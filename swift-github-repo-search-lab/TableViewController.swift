//
//  GithubSearchTableViewController.swift
//  swift-github-repo-search-lab
//
//  Created by Jhantelle Belleza on 11/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func searchButton(_ sender: UIButton) {
        var searchTextField = UITextField()
        
        let alertController = UIAlertController(title: "Search Repository", message: "Enter repository name:" , preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: { (action) in
            
            if !(searchTextField.text?.isEmpty)! {
                self.store.searchRepositories(name: String((alertController.textFields?.first?.text)!)!, completion: { (repos) in
                print(repos)
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                })
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { (textField : UITextField!) in
            textField.placeholder = "Enter Repository"
            searchTextField = textField
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let queue = OperationQueue()
        queue.qualityOfService = .background
        
        queue.addOperation {
            self.store.getRepositories {
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.fullname.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        let fullname = store.fullname[indexPath.row]
        cell.textLabel?.text = fullname
        return cell
    }
    
}
