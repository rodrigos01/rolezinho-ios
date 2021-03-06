//
//  MapViewModel.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 15/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation

class MapViewModel : NSObject {
    
    var repository: PlacesRepository
    
    var latLng = PlacesRepository.LatLng(lat: 48.852966, lng: 2.349902)
    var radius = 1500.0
    
    let places = Future<[Place]>()
    
    init(withRepository: PlacesRepository) {
        self.repository = withRepository
        super.init()
        
        loadSuggestions()
    }
    
    func setCoordinates(lat: Double, lng: Double) {
        latLng = PlacesRepository.LatLng(lat: lat, lng: lng)
        loadSuggestions()
    }
    
    private func loadSuggestions() {
        repository.loadSuggestions(withLatLng: latLng, withRadius: radius).observe {newPlaces in
            self.places.result = newPlaces
        }
    }
    
}
