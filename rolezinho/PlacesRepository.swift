//
//  FilesRepository.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 14/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation

class PlacesRepository: NSObject {
    
    func loadSuggestions(withLatLng: LatLng) -> Future<[Place]> {
        
        let url = "http://api.combah.com/places/suggestions?lat=\(withLatLng.lat)&lon=\(withLatLng.lng)&radius=15000&use_distance=0"
        
        let future = Future<[Place]>()
        URLSession.shared.request(url: url).observe { (data) in
            if let validData = data {
                if let json = try? JSONSerialization.jsonObject(with: validData, options: JSONSerialization.ReadingOptions()) {
                    if let dictionary = json as? [String : NSArray] {
                        future.result = dictionary["places"]?.map { place in
                            if let placeDict = place as? [String: Any] {
                                return Place(withDict: placeDict)
                            } else {
                                return Place()
                            }
                        }
                    }
                }
            }
        }
        return future
    }
    
    public class LatLng {
        var lat: Double
        var lng: Double
        
        init(lat: Double, lng: Double) {
            self.lat = lat
            self.lng = lng
        }
    }
    
}
