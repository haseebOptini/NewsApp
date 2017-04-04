//
//  Sources.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/1/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class GetSources: NSObject {
    weak var delegate: ServerCommunicationDelegate?
    var sourcesUrl = Url.base + Url.source
    
    func fetchSources() {
        delegate?.beforeSendingRequest(sender: self)
        Alamofire.request(sourcesUrl).validate().responseJSON {
            [weak self] (response: DataResponse<Any>) in
            guard let strongSelf = self else {
                return
            }
            switch response.result {
            case .success:
//                guard let data = Utility.sources(fromResponse: response) else {
//                    strongSelf.stopProgress(success: false, message: Generic.serverSideError)
//                    return
//                }
                guard let sources = Utility.sources(fromResponse: response) else {
                    strongSelf.stopProgress(success: false, message: Generic.serverSideError)
                    return
                }
                
                print(Utility.sources(fromResponse: response) ?? "Nil")
                strongSelf.create(sources: sources)
//                strongSelf.hasReviewed = (data["has_reviewed"] as? Bool) ?? false
//                PartnerDetail.deleteAll()
//                Product.deleteAll()
//                Review.deleteAll()
//                var partnerDict = data["partner_dict"] as? [String : AnyObject]
//                var partner = partnerDict?["partner"] as? [String : AnyObject]
//                partner?["reviews"] = data["reviews"]
//                partnerDict?["partner"] = partner as AnyObject
//                strongSelf.create(productDictionaries: data["products"] as? [[String: AnyObject]])
//                strongSelf.create(partnerDictionary: partnerDict)
                OperationQueue.main.addOperation {
                    CoreDataStackManager.shared.saveContext()
                }
                strongSelf.stopProgress(success: true, message: "")
            case .failure(let error):
                strongSelf.stopProgress(success: false, message: error.localizedDescription)
            }
        }
    }
    
    func stopProgress(success: Bool, message: String) {
        delegate?.afterFetchingResponse(sender: self, success: success, message: message)
    }
    
    func create(sources: [[String: AnyObject]]?) {
        NewsSources.deleteAll()
      /*  if let sourcesDictionaries = sources {
            let _ = sourcesDictionaries.map() { (dictionary: [String : AnyObject]) -> NewsSources in
                let newsSource = NewsSources(dictionary: dictionary)
                return newsSource
            }
            sourcesDictionaries.forEach { dict
                let newSource = NewsSources(dictionary: dict)
            }
        }  */
        
        sources?.forEach {
           _ = NewsSources(dictionary: $0)
        }
    }
}
