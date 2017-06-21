//
//  getDirectionVC.swift
//  homeFellow
//
//  Created by christopher alphonse cervantes on 6/21/17.
//  Copyright © 2017 christopher alphonse cervantes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class getDirectionVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var Longtitude: Double!
    var Latitude: Double!
    let locationmanager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //mapView.delegate = self
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        
       // let currentLocation = CLLocation()
        let currentLat = locationmanager.location?.coordinate.latitude
        let currentlong = locationmanager.location?.coordinate.longitude
        
        print("current \(currentlong)")
        print("current \(currentLat)")
        
        let destinationLong = Longtitude
        let destinationLat = Latitude
        
        print("destination \(destinationLong)")
        print("destination \(destinationLat)")
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        let request = MKDirectionsRequest()
        
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentLat!, longitude: currentlong!),addressDictionary: nil))
        
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destinationLat!, longitude: destinationLat!), addressDictionary: nil))
        
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

            let direction =  MKDirections(request: request)
        
            direction.calculate{
            [unowned self] response, error in
                guard let unwrappedResponse  = response else {
                        return
                }
            
                for route in unwrappedResponse.routes{
                    self.mapView.add(route.polyline)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect,      animated: true)
                
                }
        
            }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.fillColor = UIColor.red
        polylineRenderer.lineWidth = 2
        
        return polylineRenderer
    }
}
