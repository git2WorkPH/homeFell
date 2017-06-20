//
//  Hf_details+CoreDataProperties.swift
//  homeFellow
//
//  Created by christopher alphonse cervantes on 6/20/17.
//  Copyright © 2017 christopher alphonse cervantes. All rights reserved.
//

import Foundation
import CoreData


extension Hf_details {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hf_details> {
        return NSFetchRequest<Hf_details>(entityName: "Hf_details")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var homeaddress: String?
    @NSManaged public var hosts: String?
    @NSManaged public var latitude: Int64
    @NSManaged public var locationdescription: String?
    @NSManaged public var longtitude: Int64
    @NSManaged public var schedule: String?
    @NSManaged public var toImage: NSObject?

}
