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
//        let mainMenuStoryboard = UIStoryboard(name: "Restaurant", bundle: nil)
//        let restaurantController =
//            mainMenuStoryboard.instantiateViewController(withIdentifier: "RestaurantController")
//                as! ResturantSearchViewController
//        guard let partner = fetchedResultsController?.object(at: indexPath) as? Partner else {
//            return
//        }
//        restaurantController.selectedRestaurant = partner
//        let rightViewController =
//            mainMenuStoryboard.instantiateViewController(withIdentifier: "ResturantsRightMenu")
//                as! ResturantRightMenuViewController
//        restaurantController.resturantRightMenuViewController = rightViewController
//        SlideMenuOptions.contentViewScale = 1
//        SlideMenuOptions.hideStatusBar = false
//        SlideMenuOptions.panGesturesEnabled = true
//        let slideMenuController = SlideMenuController(mainViewController: restaurantController,
//                                                      rightMenuViewController: rightViewController)
//        
//        self.navigationController?.pushViewController(slideMenuController, animated: true)
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
//            print(Url.baseImage+cover)
            cell.sourceLogoImage.sd_setImage(with: URL(string: cover),
                                                 placeholderImage: UIImage())
        } else {
            cell.sourceLogoImage.image = UIImage(named: "restaurantListPlaceholder")
        }
//        cell.restaurantNameLabel.text = partner.name
//        cell.configureStarView(byRating: Int(partner.average_rating))
//        cell.configureDollarView(byRating: Int(partner.price_category))
//        cell.ratingsLabel.text = "\(partner.ratings_count) " + (partner.ratings_count > 1 ? "Reviews" : "Review")
//        cell.prepTimeLabel.text = (partner.prep_time == 0 ? "--" : "\(partner.prep_time)")
//        cell.configurePrepArcView(byPrepTime: Int(partner.prep_time))
//        cell.closedNowImage.isHidden = partner.isOpen
//        let concatenatedCuisines = partner.cuisines?.lazy
//            .flatMap { $0.name }.sorted()
//            .joined(separator: ", ")
//        
//        
//        cell.cusinesLabel.text = concatenatedCuisines
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
