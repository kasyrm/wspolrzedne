//
//  ViewController.swift
//  wspolrzedne
//
//  Created by Martyna Rysak on 13.10.2015.
//  Copyright (c) 2015 Martyna Rysak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let numberFormatter: NSNumberFormatter = NSNumberFormatter()
    @IBOutlet weak var fi: UITextField!
    
    @IBOutlet weak var lambda: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.showsUserLocation = true
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func znajdzLokalizacje(sender: UIBarButtonItem) {
        
        let fiDouble = numberFormatter.numberFromString(fi.text)?.doubleValue
        let lambdaDouble = numberFormatter.numberFromString(lambda.text)?.doubleValue
        
        if (fiDouble  != nil && lambdaDouble != nil) {
            wyswietlLokalizacje(fiDouble!, lambda: lambdaDouble!)
            
        }
    }
    
    
    func wyswietlLokalizacje(fi: Double, lambda: Double) {
        let a = mapView.annotations
        mapView.removeAnnotations(a)
        let location = CLLocationCoordinate2D(latitude: fi as CLLocationDegrees, longitude: lambda as CLLocationDegrees)
        let span = MKCoordinateSpanMake(0.001 as CLLocationDegrees, 0.001 as CLLocationDegrees)
        
        
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegionMake(center, span)
        mapView.setRegion(region, animated: true)
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        annotation1.title = "szukany punkt"
        mapView.addAnnotation(annotation1)
        
        
    }
    @IBAction func odswierzPolozenie(sender: UIBarButtonItem) {
        
        znajdzWlasnePolozenie()
    }
    
    func znajdzWlasnePolozenie(){
        let span = MKCoordinateSpanMake(0.001 as CLLocationDegrees, 0.001 as CLLocationDegrees)
        
        
        let center = CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
        println("\(mapView.userLocation.coordinate.latitude)")
        println( "\(mapView.userLocation.coordinate.longitude)")
        let region = MKCoordinateRegionMake(center, span)
        mapView.setRegion(region, animated: true)
    }

    
    
    func mapViewDidFinishRenderingMap(mapView: MKMapView!, fullyRendered: Bool) {
       znajdzWlasnePolozenie()
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        let fi = String(format: "%.5f",mapView.userLocation.coordinate.latitude)
        let lambda = String(format: "%.5f", mapView.userLocation.coordinate.longitude)
        mapView.userLocation.title = "φ:\(fi)° λ:\(lambda)°"
        
    }
    
    
    
    
}

