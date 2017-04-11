//
//  Article+CoreDataClass.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/7/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {
    struct Keys {
        static let author = "author"
        static let description = "description"
        static let title = "title"
        static let url = "url"
        static let urlToImage = "urlToImage"
        static let publishedAt = "publishedAt"
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(dictionary: [String : AnyObject]) {
        let entity =  NSEntityDescription.entity(forEntityName: "Article", in: NewsSources.managedContext)!
        super.init(entity: entity, insertInto: NewsSources.managedContext)
        author = (dictionary[Keys.author] as? String) ?? ""
        newsDescription = (dictionary[Keys.description] as? String) ?? ""
        url = dictionary[Keys.url] as! String?
        title = dictionary[Keys.title] as! String?
        urlToImage = dictionary[Keys.urlToImage] as? String ?? ""
        publishedAt = (dictionary[Keys.publishedAt] as? String) ?? ""
        createdAt = NSDate()
    }
    
    static var managedContext: NSManagedObjectContext {
        return CoreDataStackManager.shared.managedObjectContext
    }
    
    public class func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
            try managedContext.save()
        } catch {
            return
        }
    }
}
