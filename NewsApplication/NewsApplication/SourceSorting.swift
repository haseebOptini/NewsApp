//
//  SourceSorting+CoreDataClass.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/4/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import Foundation
import CoreData

@objc(SourceSorting)
public class SourceSorting: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(sortingType: String) {
        let entity =  NSEntityDescription.entity(forEntityName: "SourceSorting", in: NewsSources.managedContext)!
        super.init(entity: entity, insertInto: NewsSources.managedContext)
        sortType = sortingType
        createdAt = NSDate()
    }
    
    static var managedContext: NSManagedObjectContext {
        return CoreDataStackManager.shared.managedObjectContext
    }
    
}
