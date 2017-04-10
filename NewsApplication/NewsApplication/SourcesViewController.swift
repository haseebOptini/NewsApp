//
//  SourcesViewController.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/1/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit
import CoreData
import MBProgressHUD
import SDWebImage

class SourcesViewController: UIViewController {
    let getSources = GetSources()
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFetchedResultsController()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsSources")
        let createdAt = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [createdAt]
        
        getSources.delegate = self
        getSources.fetchSources()
        let moc = CoreDataStackManager.shared.managedObjectContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SourcesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainMenuStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let articlesController = mainMenuStoryboard.instantiateViewController(withIdentifier: "ArticlesViewController")
                as! ArticlesViewController
        guard let newsSource = fetchedResultsController.object(at: indexPath) as? NewsSources else {
            return
        }
        articlesController.newsSource = newsSource
        self.navigationController?.pushViewController(articlesController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension SourcesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesTableViewCell", for: indexPath) as! SourcesTableViewCell
        cell.selectionStyle = .none
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: SourcesTableViewCell, indexPath: IndexPath) {
        guard let newsSource = fetchedResultsController.object(at: indexPath) as? NewsSources else {
            return
        }
        cell.nameLabel.text = newsSource.name
        
        if let cover = newsSource.imagesUrl?.small {
            cell.sourceLogoImage.sd_setImage(with: URL(string: cover),
                                                 placeholderImage: UIImage())
        } else {
            cell.sourceLogoImage.image = UIImage(named: "restaurantListPlaceholder")
        }
    }
}

extension SourcesViewController: ServerCommunicationDelegate {
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
