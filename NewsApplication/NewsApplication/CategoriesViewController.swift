//
//  CategoriesViewController.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/7/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let tableData = ["business", "entertainment", "gaming", "general", "music", "politics", "sport", "technology"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, -48, 0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainMenuStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let articlesController = mainMenuStoryboard.instantiateViewController(withIdentifier: "ArticlesViewController")
            as! ArticlesViewController
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! SourcesTableViewCell
        cell.selectionStyle = .none
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: SourcesTableViewCell, indexPath: IndexPath) {
        cell.nameLabel.text = tableData[indexPath.row]
    }
}

