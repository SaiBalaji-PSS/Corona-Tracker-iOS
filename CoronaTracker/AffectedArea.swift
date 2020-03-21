//
//  AffectedArea.swift
//  CoronaTracker
//
//  Created by saibalaji on 21/03/20.
//  Copyright © 2020 saibalaji. All rights reserved.
//

import UIKit
import MapKit
class AffectedArea: NSObject,MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String,coordinate:CLLocationCoordinate2D)
    {
        self.title = title
        self.coordinate = coordinate
    }
}
