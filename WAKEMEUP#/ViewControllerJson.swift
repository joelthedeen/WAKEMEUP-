//
//  ViewController.swift
//  
//
//  Created by Joel Thedéen on 2020-11-02.
//

import UIKit

class Stops : Codable{
    
    var StopLocation : [SLoc]
    
    
    
}
class SLoc : Codable{
    
    var lat : Double
    var lon : Double
    var name : String
}
////
class ViewControllerJson: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadFromServerURLSESSION()
    }
    
    func loadFromServerURLSESSION()
    {
        guard let url = URL(string: "https://api.resrobot.se/location.name.json?key=f18064aa-50c1-4486-860a-158a6e6c46c3&maxNo=5&input=vallp") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        var thesession = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let thestring = String(decoding: data!, as: UTF8.self)
            
            self.gotTextFromServer(serverstring: thestring)
        }
        thesession.resume()
    }
    
    func gotTextFromServer(serverstring : String)
    {
        print(serverstring)
        
        let jsondata = Data(serverstring.utf8)
        
        let decoder = JSONDecoder()

        do {
            let stops = try decoder.decode(Stops.self, from: jsondata)
            
            for astop in stops.StopLocation
            {
                print(astop.name)
            }
            DispatchQueue.main.async {
                // RITA PÅ SKÄRMEN
            }
        } catch {
            print("Failed to decode JSON")
        }
    }
}
