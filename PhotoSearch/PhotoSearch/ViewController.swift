//
//  ViewController.swift
//  PhotoSearch
//
//  Created by Olga Matsyk on 6/4/19.
//  Copyright © 2019 Matsyk. All rights reserved.
//

import UIKit

class ViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var searchBar:UISearchBar = {
        
        let s = UISearchBar()
        s.searchBarStyle = UISearchBar.Style.minimal
        s.placeholder = "Search photo..."
        s.isTranslucent = false
        s.backgroundImage = UIImage()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.barTintColor = UIColor.init(white: 0.9, alpha: 0.5)
        
        return s
    }()
    
    let tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set a background color 
        self.view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        
        // add the table view to self.view
        self.view.addSubview(tableView)
        
        // add the search bar to header view
        tableView.tableHeaderView = searchBar

        // UI constraints
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        // set delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        
        // set delegate
        searchBar.delegate = self

        
        // register a defalut cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

