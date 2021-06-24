//
//  ViewController.swift
//  MapView
//
//  Created by TrieuLe on 4/18/21.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    static let identifier = "FirstViewController"
    @IBOutlet weak var mapView: MKMapView!
    //MARK: - Properties
    var locationManager =  CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
        guard let currentLocation = locationManager.location?.coordinate else {
            print("Cannot get current location from LM.")
            return
        }
        let annotation = CustomAnnotation(title: "FSoft HCM", subtitle: "Đường D1, Khu Công Nghệ Cao, Phường Tân Phú, TP.Thủ Đức", image: UIImage(named: "demo_annotation"), coordinate: CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude))
        mapView.addAnnotation(annotation)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            print("Get current location fail.")
            return
        }
        let region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let mAnnotation = annotation as? CustomAnnotation {
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomPinView")
            if pinView == nil {
                pinView = MKAnnotationView(annotation: mAnnotation, reuseIdentifier: "CustomPinView")
                pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                pinView?.canShowCallout = true
                pinView?.calloutOffset = CGPoint(x: 0, y: 4)
                pinView?.contentMode = .scaleAspectFit
            } else {
                pinView?.annotation = annotation
            }
            pinView?.image = mAnnotation.image
            return pinView
        }
        return nil
    }
    
}

