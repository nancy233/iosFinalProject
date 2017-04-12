//
//  MapViewController.swift
//  Anime In Life
//
//  Created by nancy on 3/21/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController:UIViewController{

    var prefec:String?
    @IBOutlet weak var Map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for loc in locations[prefec!]!{
            var span = MKCoordinateSpanMake(0.2, 0.2)
            var region = MKCoordinateRegion(center:loc, span:span)
            
            Map.setRegion(region, animated: true)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = loc
            
            Map.addAnnotation(annotation)
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
