//
//  ArticlesViewController.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/1/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD
import SDWebImage

class ArticlesViewController: UIViewController {
    var newsSource: NewsSources?
    let getArticles = GetArticles()
    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles.sourceId = newsSource?.id
        tableView.delegate = self
        tableView.dataSource = self
        initializeFetchedResultsController()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(0, 0, -48, 0);
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let createdAt = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [createdAt]
        
        getArticles.delegate = self
        getArticles.fetchArticles()
        let moc = CoreDataStackManager.shared.managedObjectContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    }
}

extension ArticlesViewController: ServerCommunicationDelegate {
    func beforeSendingRequest(sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func afterFetchingResponse(sender: Any, success: Bool, message: String) {
        OperationQueue.main.addOperation {
            [weak self] in
            guard let strongSelf = self else {
                return
            }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            if success {
                do {
                    try strongSelf.fetchedResultsController.performFetch()
                } catch {
                }
                strongSelf.tableView.reloadData()
            } else {
                strongSelf.showOKAlert(title: Generic.error, message: message)
            }
        }
    }
}

extension ArticlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainMenuStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let articleDetailController = mainMenuStoryboard.instantiateViewController(withIdentifier: "ArticleDetailViewController")
            as! ArticleDetailViewController
        guard let article = fetchedResultsController.object(at: indexPath) as? Article else {
            return
        }
        articleDetailController.article = article
        self.navigationController?.pushViewController(articleDetailController, animated: true)
    }
    
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: Set the size of the uitable view cell to dynamic size
//        return 150
        return UITableViewAutomaticDimension
    }*/
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.selectionStyle = .none
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: ArticleTableViewCell, indexPath: IndexPath) {
        guard let article = fetchedResultsController.object(at: indexPath) as? Article else {
            return
        }
        cell.titleLabel.text = article.title
        
        if let cover = article.urlToImage {
            cell.titleImage.sd_setImage(with: URL(string: cover),
                                             placeholderImage: UIImage(named: "restaurantListPlaceholder"))
//            cell.titleImage.sd_setImage(with: URL(string: cover) , completed: { (image, error, cache, url) in
//                if let cellIndexPath = self.tableView.indexPath(for: cell) {
//                    self.tableView.reloadRows(at: [cellIndexPath], with: .automatic)
//                }
//            })
        } else {
            cell.titleImage.image = UIImage(named: "restaurantListPlaceholder")
        }
    }
}


