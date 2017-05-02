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
import Firebase



class MapViewController:UIViewController, MKMapViewDelegate{

    var prefec:String?
    var locToKey = [MKPointAnnotation:String]()

    
    @IBOutlet weak var Map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Map.delegate = self
        self.title = prefec!
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Region").child(prefec!).child("Locations").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let myLoc = snapshot.value as! [String:[String:Any]]
                for key in myLoc.keys{
                    let latitude = myLoc[key]?["latitude"] as! CLLocationDegrees
                    let longitude = myLoc[key]?["longitude"] as! CLLocationDegrees
                    let location = CLLocationCoordinate2DMake(latitude, longitude)
                    
                    let span = MKCoordinateSpanMake(0.5, 0.5)
                    let region = MKCoordinateRegion(center:location, span:span)
                    self.Map.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    self.Map.addAnnotation(annotation)
                    self.locToKey[annotation] = key
                }
            }else{
                print("child of selected prefec not exist")
            }
        })
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "fromMap", sender: view)
        
        let selectedAnnotations = mapView.selectedAnnotations
        for annotation in selectedAnnotations {
            mapView.deselectAnnotation(annotation, animated: false)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ScenesFromMapViewController {
            let annotationView = sender as? MKAnnotationView
            destination.annotation = annotationView?.annotation as! MKPointAnnotation
            destination.locToKey = self.locToKey
            destination.prefec = self.prefec
        }
    }

}
