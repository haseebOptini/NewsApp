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
                guard let sources = Utility.sources(fromResponse: response) else {
                    strongSelf.stopProgress(success: false, message: Generic.serverSideError)
                    return
                }
                //TODO: This line of code shows json in form of string
//                print(Utility.sources(fromResponse: response) ?? "Nil")
                strongSelf.create(sources: sources)
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
        sources?.forEach {
           _ = NewsSources(dictionary: $0)
        }
    }
}
