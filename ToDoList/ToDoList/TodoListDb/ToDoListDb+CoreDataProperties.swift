//
//  ToDoListDb+CoreDataProperties.swift
//  ToDoList
//
//  Created by Bharath on 16/05/24.
//
//

import Foundation
import CoreData


extension ToDoListDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListDb> {
        return NSFetchRequest<ToDoListDb>(entityName: "ToDoListDb")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}

extension ToDoListDb : Identifiable {

}
