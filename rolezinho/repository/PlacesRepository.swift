//
//  FilesRepository.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 14/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation

class PlacesRepository: NSObject {
    
    func loadSuggestions(withLatLng: LatLng, withRadius: Double = 1500) -> Future<[Place]> {
        
        let url = "http://api.combah.com/places/suggestions?lat=\(withLatLng.lat)&lon=\(withLatLng.lng)&radius=\(withRadius)&use_distance=0"
        
        let future = Future<[Place]>()
        URLSession.shared.request(url: url).observe { (data) in
            if let validData = data {
                if let json = try? JSONSerialization.jsonObject(with: validData, options: JSONSerialization.ReadingOptions()) {
                    if let dictionary = json as? [String : [[String : Any]]] {
                        future.result = dictionary["places"]?.flatMap{ Place(withDict: $0) }
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
