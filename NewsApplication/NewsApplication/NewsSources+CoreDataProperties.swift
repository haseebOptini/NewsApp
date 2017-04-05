//
//  NewsSources+CoreDataProperties.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/5/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import Foundation
import CoreData


extension NewsSources {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsSources> {
        return NSFetchRequest<NewsSources>(entityName: "NewsSources");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var sourceDescription: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var imagesUrl: ImagesUrl?
    @NSManaged public var sourceSorting: NSSet?

}

// MARK: Generated accessors for sourceSorting
extension NewsSources {

    @objc(addSourceSortingObject:)
    @NSManaged public func addToSourceSorting(_ value: SourceSorting)

    @objc(removeSourceSortingObject:)
    @NSManaged public func removeFromSourceSorting(_ value: SourceSorting)

    @objc(addSourceSorting:)
    @NSManaged public func addToSourceSorting(_ values: NSSet)

    @objc(removeSourceSorting:)
    @NSManaged public func removeFromSourceSorting(_ values: NSSet)

}
