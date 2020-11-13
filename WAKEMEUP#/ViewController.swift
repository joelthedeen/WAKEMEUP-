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
import AVFoundation


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var slider: MSCircularSlider!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var textFieldActive: UITextField!
    
    @IBOutlet weak var kmTextfield: UITextField!
    
    @IBOutlet weak var searchTableview: UITableView!
    
    var distance = 0
    var timer : Timer?

    var startPos : CLLocation?
    var endPos : CLLocation?

    var checkActive : Bool = true
    
    var stopResult : Stops?
    override func viewDidLoad() {
        super.viewDidLoad()

        
       locationManager = CLLocationManager()
       locationManager.requestAlwaysAuthorization()
       locationManager.requestWhenInUseAuthorization()
       locationManager.delegate = self
        
        //searchTableview.isHidden = true
    }
    
    //TABLEVIEW
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if(stopResult != nil)
        {
            return stopResult!.StopLocation.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchFieldCell") as! destinationSearchVC
        cell.searchText.text = stopResult!.StopLocation[indexPath.row].name
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chosenStop = stopResult!.StopLocation[indexPath.row]
        
        startPos = locationManager.location!
        endPos = CLLocation(latitude: chosenStop.lat, longitude: chosenStop.lon)

        updateUI()
        
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
        endPos = CLLocation(latitude: 60.61667, longitude: 16.76667)

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
 
 
    @IBAction func enterDestination(_ sender: Any) {
        if let inputText = textFieldActive.text{
            
            let res = Trafiklab().loadFromServerURLSESSION(inputText) { result in
                
                self.stopResult = result
                
                DispatchQueue.main.async {
                    if(result == nil)
                    {
                        // GÖM TABLEVIEW
                        self.searchTableview.isHidden = true
                    } else {
                        // VISA TABLEVIEW
                        self.searchTableview.isHidden = false
                        self.searchTableview.reloadData()
                    }
                }
                
                
            }
            
            print("query is now:",res)

            // call the function for api-call
        }
        
     /*   if textFieldActive.text != "" {
            VCJson?.loadFromServerURLSESSION(textFieldActive.text!)
            // call the function for api-call
        }
        */
        
    }
     

    
    

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
  /*
    
    //@IBOutlet weak var hideStartInfo: UIButton!
    
    @IBAction func toggleBtn(_ sender: Any) {
    

            checkActive = !checkActive
            
            if checkActive {
                hideStartInfo.setImage(unCheckedBox, for: .normal)
              print("box unchecked")
            } else {
                hideStartInfo.setImage(checkedBoxBlue, for: .normal)
                print("box checked")
            }
        }
*/

}
    

