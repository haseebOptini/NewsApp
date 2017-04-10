//
//  Utility.swift
//  Cheetay
//
//  Created by arbisoft on 11/23/16.
//  Copyright © 2016 Cheetay. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class Utility {
    class func data(fromResponse response: DataResponse<Any>) -> [String: AnyObject]? {
        guard let jsonResponse = response.result.value else {
            return nil
        }
        guard let dataDictionary = (jsonResponse as! [String: AnyObject])["data"] as? [String : AnyObject]  else {
            return nil
        }
        return dataDictionary
    }
    
    class func sources(fromResponse response: DataResponse<Any>) -> [[String: AnyObject]]? {
        guard let jsonResponse = response.result.value else {
            return nil
        }
        print((jsonResponse as! [String: AnyObject])["sources"] ?? "nil")
        guard let dataDictionary = (jsonResponse as! [String: AnyObject])["sources"] as? [[String : AnyObject]]  else {
            return nil
        }
        return dataDictionary
    }
    
    class func articles(fromResponse response: DataResponse<Any>) -> [[String: AnyObject]]? {
        guard let jsonResponse = response.result.value else {
            return nil
        }
        print((jsonResponse as! [String: AnyObject])["articles"] ?? "nil")
        guard let dataDictionary = (jsonResponse as! [String: AnyObject])["articles"] as? [[String : AnyObject]]  else {
            return nil
        }
        return dataDictionary
    }
    
    class func errorMessage(from response: DataResponse<Any>) -> String? {
        let json = response.data.flatMap { (data: Data) -> [String : AnyObject]? in 
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject] else {
                return nil
            }
            return json
        }
        return json?["message"] as? String
    }
    
    class func string(fromJson json: AnyObject) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
    
    class func date(fromISO8601 string: String) -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)
        return date as NSDate?
    }
    
    class func string(fromISO8601 date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateStr = dateFormatter.string(from: date)
        return dateStr as String
    }
    
}
