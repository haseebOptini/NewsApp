//
//  NewsSources+CoreDataClass.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/2/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(NewsSources)
public class NewsSources: NSManagedObject {
    struct Keys {
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let url = "url"
        static let category = "category"
        static let language = "language"
        static let urlsToLogos = "urlsToLogos"
        static let sortBysAvailable = "sortBysAvailable"
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(dictionary: [String : AnyObject]) {
        let entity =  NSEntityDescription.entity(forEntityName: "NewsSources", in: NewsSources.managedContext)!
        super.init(entity: entity, insertInto: NewsSources.managedContext)
        id = dictionary[Keys.id] as! String?
        name = dictionary[Keys.name] as! String?
        sourceDescription = dictionary[Keys.description] as! String?
        createdAt = NSDate()
        
        if let logosURL = dictionary[Keys.urlsToLogos] as? [String: AnyObject] {
            let imageUrls = ImagesUrl(dictionary: logosURL)
            imageUrls.newsSources = self
        }
        
        if let sourceSortingParemters = dictionary[Keys.sortBysAvailable] as? [String] {
            var sortingParemeters = NSSet()
            for sortType in sourceSortingParemters {
                let sortingParemeter = SourceSorting(sortingType: sortType)
                sortingParemeters = sortingParemeters.adding(sortingParemeter) as NSSet
            }
            sourceSorting = sortingParemeters
        }
    }
        
    public class func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsSources")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
            try managedContext.save()
        } catch {
            return
        }
    }
    
    public class func allSourcesCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsSources")
        do {
            let partners = try managedContext.fetch(fetchRequest) as! [NewsSources]
            return partners.count
        } catch {
            return 0
        }
    }
    
    static var managedContext: NSManagedObjectContext {
        return CoreDataStackManager.shared.managedObjectContext
    }

}
