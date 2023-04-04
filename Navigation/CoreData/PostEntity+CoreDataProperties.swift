//
//  PostEntity+CoreDataProperties.swift
//  Navigation
//
//  Created by Дина Шварова on 04.04.2023.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var descript: String?
    @NSManaged public var image: String?
    @NSManaged public var likes: Int64
    @NSManaged public var views: Int64

}

extension PostEntity : Identifiable {

}
