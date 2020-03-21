//
//  SecondViewController.swift
//  CoronaTracker
//
//  Created by saibalaji on 21/03/20.
//  Copyright © 2020 saibalaji. All rights reserved.
//

import UIKit
import MapKit


import Foundation

// MARK: - Welcome
struct Rootstruct: Codable {
    let locations: [location]
}

// MARK: - Location
struct location: Codable {
    let coordinates: Coordinates
    let country, countryCode: String
    let id: Int
    let lastUpdated: String
    let latest: latest
    let province: String
    
    enum CodingKeys: String, CodingKey {
        case coordinates, country
        case countryCode = "country_code"
        case id
        case lastUpdated = "last_updated"
        case latest, province
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}

// MARK: - Latest
struct latest: Codable {
    let confirmed, deaths, recovered: Int
}









class SecondViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

      // let  city = AffectedArea(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: 0.1278))
        //mapview.addAnnotations([city])
        
      //  fetchdata()
    }
    
    
    func fetchdata()
    {
        
         let url = URL(string: "https://coronavirus-tracker-api.herokuapp.com/v2/locations")
        
        let session = URLSession.shared
        
        let data = session.dataTask(with: url!) { (data, response, error) in
            var decoder = JSONDecoder()
            
            do
            {
                 var info = try decoder.decode(Rootstruct.self, from: data!)
                
                DispatchQueue.main.async {
                    for i in 0..<info.locations.count
                    {
                        var pin = AffectedArea(title: info.locations[i].province, coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(info.locations[i].coordinates.latitude)!, longitude: CLLocationDegrees(info.locations[i].coordinates.longitude) ?? 00))
                        self.mapview.addAnnotations([pin])
                    }
                }

            }
            catch
            {
               print(error)
            }
        }.resume()
        
        
    }
    
    
    
    @IBAction func get(_ sender: UIButton) {
        
        fetchdata()
    }
    //° N, ° W

}
