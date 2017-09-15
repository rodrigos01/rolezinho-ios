//
//  Place.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 14/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation

class Place: NSObject {
    var id: String = ""
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var coverImage: String? = nil
    
    override init() {
        
    }
    
    init(withDict: [String : Any]) {
        self.id = withDict["id"] as? String ?? ""
        self.name = withDict["name"] as? String ?? ""
        self.latitude = withDict["latitude"] as? Double ?? 0.0
        self.longitude = withDict["longitude"] as? Double ?? 0.0
        self.coverImage = withDict["cover_image"] as? String
    }
}
