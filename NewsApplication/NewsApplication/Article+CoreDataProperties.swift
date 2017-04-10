//
//  Article+CoreDataProperties.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/7/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article");
    }

    @NSManaged public var author: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var createdAt: NSDate?
}
