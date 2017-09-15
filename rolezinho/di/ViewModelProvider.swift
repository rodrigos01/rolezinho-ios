//
//  ViewModelProvider.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 15/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation

class ViewModelProvider: NSObject {
    class func provideMapViewModel() -> MapViewModel {
        let repository = PlacesRepository()
        return MapViewModel(withRepository: repository)
    }
}
