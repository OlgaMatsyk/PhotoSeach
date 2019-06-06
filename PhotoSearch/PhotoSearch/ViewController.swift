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
        
        let s = UISearchBar(frame: .zero)
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
    
    private let searchService: PhotoSearchService = {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GiphyApiKey") as! String
        let rapidApiKey = Bundle.main.object(forInfoDictionaryKey: "X-RapidAPI-Key") as! String

        return PhotoSearchService(key: apiKey, rapidApiKey: rapidApiKey)
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
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchService.findPhotos(query: searchBar.text ?? "") {
            [unowned self] result in

            switch result {
            case .Success:
                self.tableView.reloadData()

            case .Error(let error):
                print(error)
                switch error {
                case PhotoSearchError.ParseError:
                    let alert = UIAlertController(title: "Error!", message: "Parse error.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                case PhotoSearchError.NoSuchPhoto:
                    let alert = UIAlertController(title: "Error!", message: "Photo not found.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                default:
                    break;
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DBManager.sharedInstance.getDataFromDB().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let photo = DBManager.sharedInstance.getDataFromDB() [indexPath.row] as Photo
        cell.textLabel?.text = photo.title
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        cell.imageView?.image = nil
        cell.imageView?.isHidden = false
        
        if let imageData = NSData(contentsOf: URL(string:photo.url)!) {
            DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
            }
        }
       
        return cell
        
    }
}

