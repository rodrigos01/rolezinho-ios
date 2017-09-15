//
//  ViewController.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 14/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var map: MKMapView!
    
    let viewModel = ViewModelProvider.provideMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let coordinate = CLLocationCoordinate2DMake(viewModel.latLng.lat, viewModel.latLng.lng)
        let radius = viewModel.radius
        
        map.region = MKCoordinateRegionMakeWithDistance(coordinate, radius, radius)
        map.isScrollEnabled = true
        map.isZoomEnabled = true
        map.isPitchEnabled = true
        map.isRotateEnabled = true
        map.showsPointsOfInterest = false
        
        map.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        viewModel.places.observe { (places) in
            self.showMapAnnotations(places: places)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.setCoordinates(lat: mapView.region.center.latitude, lng: mapView.region.center.longitude)
    }
    
    private func showMapAnnotations(places: [Place]?) {
        DispatchQueue.main.async {
            places?.map({ (place) -> MKPointAnnotation in
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(place.latitude, place.longitude)
                annotation.title = place.name
                return annotation
            }).filter({ (annotation) -> Bool in
                !self.map.annotations.contains(where: { $0 as? MKPointAnnotation == annotation })
            }).forEach({ (annotation) in
                self.map.addAnnotation(annotation)
            })
        }
    }


}

