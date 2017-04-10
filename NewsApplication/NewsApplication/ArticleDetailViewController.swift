//
//  ArticleDetailViewController.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/7/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var writterLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let articleDetails = article {
            titleLabel.text = articleDetails.title
            publishedDateLabel.text = articleDetails.publishedAt ?? ""
            detailsLabel.text = articleDetails.newsDescription
            writterLabel.text = articleDetails.author ?? ""
            if let cover = articleDetails.urlToImage {
                titleImage.sd_setImage(with: URL(string: cover),
                                                 placeholderImage: UIImage())
            } else {
                titleImage.image = UIImage(named: "restaurantListPlaceholder")
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
