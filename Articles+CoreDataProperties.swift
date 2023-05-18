//
//  Articles+CoreDataProperties.swift
//  
//
//  Created by Muna Abdelwahab on 18/05/2023.
//
//

import Foundation
import CoreData


extension Articles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Articles> {
        return NSFetchRequest<Articles>(entityName: "Articles")
    }

    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var url: String?
}
