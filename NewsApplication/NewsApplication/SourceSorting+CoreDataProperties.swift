//
//  SourceSorting+CoreDataProperties.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/4/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import Foundation
import CoreData


extension SourceSorting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceSorting> {
        return NSFetchRequest<SourceSorting>(entityName: "SourceSorting");
    }

    @NSManaged public var sortType: String?
    @NSManaged public var newsSources: NewsSources?

}
