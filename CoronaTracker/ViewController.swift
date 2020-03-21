//
//  ViewController.swift
//  CoronaTracker
//
//  Created by saibalaji on 20/03/20.
//  Copyright © 2020 saibalaji. All rights reserved.
//
import UIKit

import Foundation


struct Welcome: Codable {
    let latest: Latest
}


struct Latest: Codable {
    let confirmed, deaths, recovered: Int
}

/*Feel free to contribute to this project*/

class ViewController: UIViewController {

    @IBOutlet weak var dcountlbl: UILabel!
    @IBOutlet weak var ccountlbl: UILabel!
    @IBOutlet weak var recoverycountlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getdata(_ sender: UIButton) {
        
        let url = URL(string: "https://coronavirus-tracker-api.herokuapp.com/v2/latest")//End Point url
        
        let session = URLSession.shared
        
       var data = session.dataTask(with: url!) { (data, response, error) in //Parse the json in background task
            
            let decoder = JSONDecoder()
            do
            {
                
                  var info = try decoder.decode(Welcome.self, from: data!)//Decode the JSON as Welcome struct
                
                DispatchQueue.main.async {//Changes to UI can be made only in main thread hence this block of code excecute in the main thread
                    self.recoverycountlbl.text = String(info.latest.recovered)
                    self.ccountlbl.text = String(info.latest.confirmed)
                    self.dcountlbl.text = String(info.latest.deaths)
                }
                
            }
            catch
            {
                print("Error")
            }
        }.resume()//Resume the task if it is suspended
        
        
    }
    
}

