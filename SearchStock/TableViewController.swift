//
//  TableViewController.swift
//  SearchStock
//
//  Created by Jonathan Velazquez on 11/17/17.
//  Copyright © 2017 Jonathan Velazquez. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    //JSON URL
    final let url = URL(string: "https://jonathanvelazquez.github.io/doc/stocks.json")
    
    //Holds values of the JSON Data
    private var stocks = [Stocks]()
    
    //Holds value of onle the Names of the Stocks
    var stockArray = [String]()
    
    //Array used to filter when Searching
    var filteredArray = [String]()
    
    var searchController = UISearchController()
    var resultController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        self.searchController = UISearchController(searchResultsController: resultController)
        tableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchResultsUpdater = self
        
        self.resultController.tableView.delegate = self
        self.resultController.tableView.dataSource = self
        
        
        
        
    }
    
    func parseJson() {
        
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Error connecting to URL")
                return
            }
            
            print("Success")
           
            do {
                
                let decoder = JSONDecoder()
                
                let downloadedStocks = try decoder.decode([Stocks].self, from: data)
                
                self.stocks = downloadedStocks
                //print(self.stocks[0].name)
                let count = self.stocks.count
                var index:Int = 0
                
                //pull the name data from the the json data array
                while ( index < count){
                    self.stockArray.append(self.stocks[index].name)
                    index += 1
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        self.filteredArray = stockArray.filter({ (array: String) -> Bool in
            
            if array.contains(searchController.searchBar.text!)
            {
                return true
            }
            else
            {
                return false
            }
            
        })
        
        self.resultController.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == resultController.tableView
        {
            return self.filteredArray.count
        }
        else
        {
            
            return self.stockArray.count
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        
        
        if tableView == resultController.tableView
        {
            
            cell.textLabel?.text = self.filteredArray[indexPath.row]
        }
        else
        {
            cell.textLabel?.text = self.stockArray[indexPath.row]
        }
        
        
        
        return cell
        
        
        
        
    }
    
    
}


