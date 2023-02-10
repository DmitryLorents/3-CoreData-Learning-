//
//  Book+CoreDataProperties.swift
//  3-CoreData(Learning)
//
//  Created by Mac on 10.02.2023.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var user: User?

}

extension Book : Identifiable {

}
