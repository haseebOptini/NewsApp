//
//  GetArticles.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/7/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class GetArticles: NSObject {
    weak var delegate: ServerCommunicationDelegate?
    var articlesUrl = Url.base + Url.articles
    var sourceId: String?
    
    func fetchArticles() {
        if let sourceId = sourceId {
            articlesUrl = "\(articlesUrl)?source=\(sourceId)&\(Generic.apiKey)"
        } else {
            self.stopProgress(success: false, message: Warnings.noSourceID)
        }
        delegate?.beforeSendingRequest(sender: self)
        Alamofire.request(articlesUrl).validate().responseJSON {
            [weak self] (response: DataResponse<Any>) in
            guard let strongSelf = self else {
                return
            }
            switch response.result {
            case .success:
                guard let sources = Utility.articles(fromResponse: response) else {
                    strongSelf.stopProgress(success: false, message: Generic.serverSideError)
                    return
                }
                //TODO: This line of code shows json in form of string
                print(Utility.string(fromJson: sources as AnyObject) ?? "Nil")
                strongSelf.create(articles: sources)
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
    
    func create(articles: [[String: AnyObject]]?) {
        Article.deleteAll()
        articles?.forEach {
            _ = Article(dictionary: $0)
        }
    }
}
