//
//  Spot+CoreDataProperties.swift
//  MyProject(pet)
//
//  Created by hsiao Wei lung on 2017/12/4.
//  Copyright © 2017年 hsiao Wei lung. All rights reserved.
//
//

import Foundation
import CoreData


extension Spot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spot> {
        return NSFetchRequest<Spot>(entityName: "Spot")
    }

    @NSManaged public var animal: String?
    @NSManaged public var birth: NSDate?
    @NSManaged public var gender: String?
    @NSManaged public var image: NSData?
    @NSManaged public var name: String?

}
