//
//  ViewController.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-10-14.
//

import UIKit
import MSCircularSlider
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {


    
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var slider: MSCircularSlider!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    var distance = 0
    var timer : Timer?

    var startPos : CLLocation?
    var endPos : CLLocation?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       locationManager = CLLocationManager()
       locationManager.requestAlwaysAuthorization()
       locationManager.requestWhenInUseAuthorization()
       locationManager.delegate = self
            
    }
    
    //TABLEVIEW
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchFieldCell") as! destinationSearchVC
        cell.searchText.text = "Destinationsexempel"
    
        return cell
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {     //Keyboard hide on touch
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
      }
    
    func setValuesForDistance() {
        distance = 224
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateDistance), userInfo: nil, repeats: true)
    }
    
    @objc func updateDistance(){
        if distance > 0 {
            slider._currentValue = 100 - Double(distance)
            
            distance -= 1
        }else {
            // du är framme skicka wakeup alert!
        }
    }
    
  
    
    
    @IBAction func startBtn(_ sender: Any) {
        
        startPos = CLLocation (latitude: 55.609934, longitude: 13.007176)
        endPos = CLLocation(latitude: 55.706461, longitude: 13.186557)

        updateUI()
        //timer?.invalidate()
        //setValuesForDistance()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeLocalization funkar")
        
        if CLLocationManager.locationServicesEnabled() {
            print ("LOCATION ENABLED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
        updateUI()
        /*
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        
        print(userLocation)
        
        if(startPos != nil)
        {
            var totalDistance = endPos!.distance(from: startPos!)
            
            var distanceNow = endPos!.distance(from: userLocation)
            
            var percentDone = 1 - (distanceNow/totalDistance)
            
            print("totalDistance \(totalDistance)")
            print("distanceNow \(distanceNow)")
            print(percentDone)
            
            slider._currentValue = 100 - (percentDone * 100)
        }
        */
        
    }
    
    
//    func distance(from: CLLocation) -> CLLocationDistance{
//        locationManager
//
//        return
 
 
 
 

    @IBAction func sliderValueChanged(_ sender: Any) {                              //connect slider to labels
        
        /*
        var totalDistance = endPos!.distance(from: startPos!)
        
        var distanceNow = endPos!.distance(from: userLocation)
        
        var percentDone = 1 - (distanceNow/totalDistance)
        
        distanceLabel.text = "\(Int(slider.currentValue))km"
        percentLabel.text = "\(Int(slider.currentValue))%"
        */
    }
                                                                                        //get userLocation

    func updateUI()
    {
        if let userLocation = locationManager.location
        {
            print(userLocation)
            if(startPos != nil)
            {
                var totalDistance = endPos!.distance(from: startPos!)
                
                var distanceNow = endPos!.distance(from: userLocation)
                
                var percentDone = 1 - (distanceNow/totalDistance)
                
                slider._currentValue = 100 - (percentDone * 100)
                distanceLabel.text = "\(Int(distanceNow / 1000))km"
                percentLabel.text = "\(Int(percentDone * 100))%"
            }
            
        }
    }
    
}
    
    
    
   
    
    
   
    


