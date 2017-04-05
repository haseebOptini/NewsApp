//
//  ImagesUrl+CoreDataProperties.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/5/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import Foundation
import CoreData


extension ImagesUrl {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImagesUrl> {
        return NSFetchRequest<ImagesUrl>(entityName: "ImagesUrl");
    }

    @NSManaged public var large: String?
    @NSManaged public var medium: String?
    @NSManaged public var small: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var newsSources: NewsSources?

}
