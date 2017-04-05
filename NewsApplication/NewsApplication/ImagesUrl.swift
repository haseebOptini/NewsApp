//
//  ImagesUrl+CoreDataClass.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/4/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import Foundation
import CoreData

@objc(ImagesUrl)
public class ImagesUrl: NSManagedObject {

    struct Keys {
        static let small = "small"
        static let medium = "medium"
        static let large = "large"
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(dictionary: [String : AnyObject]) {
        let entity =  NSEntityDescription.entity(forEntityName: "ImagesUrl", in: NewsSources.managedContext)!
        super.init(entity: entity, insertInto: NewsSources.managedContext)
        small = dictionary[Keys.small] as! String?
        medium = dictionary[Keys.medium] as! String?
        large = dictionary[Keys.large] as! String?
        createdAt = NSDate()
    }
    
    static var managedContext: NSManagedObjectContext {
        return CoreDataStackManager.shared.managedObjectContext
    }

}
