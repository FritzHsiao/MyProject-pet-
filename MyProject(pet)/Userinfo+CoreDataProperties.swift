//
//  Userinfo+CoreDataProperties.swift
//  MyProject(pet)
//
//  Created by hsiao Wei lung on 2017/12/1.
//  Copyright © 2017年 hsiao Wei lung. All rights reserved.
//
//

import Foundation
import CoreData


extension Userinfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Userinfo> {
        return NSFetchRequest<Userinfo>(entityName: "Userinfo")
    }

    @NSManaged public var name: String?
    @NSManaged public var animal: String?
    @NSManaged public var birth: NSDate?
    @NSManaged public var gender: String?

}
