//
//  CustomAnnotation.swift
//  MapView
//
//  Created by TrieuLe on 4/18/21.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    
    init(title: String, subtitle: String, image: UIImage?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.coordinate = coordinate
        super.init()
    }
}
