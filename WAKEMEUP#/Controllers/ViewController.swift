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
import UserNotifications




class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    
    
    @IBOutlet weak var slider: MSCircularSlider!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var textFieldActive: UITextField!
    @IBOutlet weak var kmTextfield: UITextField!
    @IBOutlet weak var searchTableview: UITableView!
    
    
    @IBOutlet weak var recentButton1: UIButton!
    @IBOutlet weak var recentButton2: UIButton!
    @IBOutlet weak var recentButton3: UIButton!
    
    public var kKmWakeup: Int = 0
    
    var finalDestination: String = ""
    var distance = 0
    var timer : Timer?
    var checkActive : Bool = true
    var destinationText:String = ""
    var recentList = [[String : Any]]()
    
    
    
    var stopResult : Stops?
    var player: AVAudioPlayer?
    var locationManager = CLLocationManager()
    var startPos : CLLocation?
    var endPos : CLLocation?
    let userDefaults = UserDefaults.standard
    
    
    var currentStop : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        LocationNotification().getAuthorization()
        
        let center = UNUserNotificationCenter.current()
        
        
        center.getPendingNotificationRequests() { allpend in
            print(allpend.count)
            for pend in allpend
            {
                print(pend.identifier)
                
            }
            
        }
        
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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(named: "darkBlue")
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chosenStop = stopResult!.StopLocation[indexPath.row]
        finalDestination = chosenStop.name
        
        var recentList = [[String : Any]]()
        
        if let savedList = UserDefaults.standard.array(forKey: "recents") as? [[String : Any]]
        {
            recentList = savedList
        }
        
        var saveLoc = [String : Any]()
        saveLoc["name"] = chosenStop.name
        saveLoc["lat"] = chosenStop.lat
        saveLoc["lon"] = chosenStop.lon
        
        recentList.append(saveLoc)
        
        if(recentList.count == 4)
        {
            recentList.remove(at: 0)
        }
        
        UserDefaults.standard.setValue(recentList, forKeyPath: "recents")
        
        updateRecents()
        
        locationManager.startUpdatingLocation()
        
        startPos = locationManager.location!
        endPos = CLLocation(latitude: chosenStop.lat, longitude: chosenStop.lon)
        
        kKmWakeup = Int(kmTextfield.text!) ?? 0
        LocationNotification().postNotification(notificationMessage: "Gather your things, you're almost there..", loc: endPos!.coordinate, radius: Double(kKmWakeup))
        
        
        updateUI()
        textFieldActive.text = stopResult!.StopLocation[indexPath.row].name
        searchTableview.isHidden = true
        
        var saveCurrentLoc = [String : Any]()
        saveCurrentLoc["name"] = finalDestination
        saveCurrentLoc["startlat"] = startPos?.coordinate.latitude
        saveCurrentLoc["startlon"] = startPos?.coordinate.longitude
        saveCurrentLoc["endlat"] = endPos?.coordinate.latitude
        saveCurrentLoc["endlon"] = endPos?.coordinate.longitude
        saveCurrentLoc["km"] = kKmWakeup
        
        UserDefaults.standard.setValue(saveCurrentLoc, forKey: "saveCurrentLoc")

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let saveCurr = UserDefaults.standard.dictionary(forKey: "saveCurrentLoc")
        {
            finalDestination = saveCurr["name"] as! String
            startPos = CLLocation(latitude: saveCurr["startlat"] as! Double, longitude: saveCurr["startlon"] as! Double)
            endPos = CLLocation(latitude: saveCurr["endlat"] as! Double, longitude: saveCurr["endlon"] as! Double)
            
            textFieldActive.text = finalDestination
            
            kKmWakeup = saveCurr["km"] as! Int
            
            kmTextfield.text = String(kKmWakeup)
            
            updateUI()
        }
        
        
       
        
        
        updateRecents()
    }
    
    func updateRecents()
    {
        
        
        if let savedList = UserDefaults.standard.array(forKey: "recents") as? [[String : Any]]
        {
            recentList = savedList
        }
        
        recentButton1.setTitle("", for: .normal)
        recentButton2.setTitle("", for: .normal)
        recentButton3.setTitle("", for: .normal)
        
        
        if(recentList.count > 0)
        {
            recentButton1.setTitle((recentList[0]["name"] as! String), for: .normal)
        }
        if(recentList.count > 1)
        {
            recentButton2.setTitle((recentList[1]["name"] as! String), for: .normal)
        }
        if(recentList.count > 2)
        {
            recentButton3.setTitle((recentList[2]["name"] as! String), for: .normal)
        }
        
    }
    
    
    @IBAction func goRecent1(_ sender: Any) {
        var recentList = [[String : Any]]()
        
        if let savedList = UserDefaults.standard.array(forKey: "recents") as? [[String : Any]]
        {
            recentList = savedList
        }
        
        if(recentList.count > 0)
        {
            startPos = locationManager.location!
            endPos = CLLocation(latitude: recentList[0]["lat"] as! Double, longitude: recentList[0]["lon"] as! Double)
            // destinationText = HITTA SLUTDESTINATION
            
            finalDestination = recentList[0]["name"] as! String
            
            kKmWakeup = Int(kmTextfield.text!) ?? 0
            LocationNotification().postNotification(notificationMessage: "Gather your things, you're almost there..", loc: endPos!.coordinate, radius: Double(kKmWakeup))
            
            var saveCurrentLoc = [String : Any]()
            saveCurrentLoc["name"] = finalDestination
            saveCurrentLoc["startlat"] = startPos?.coordinate.latitude
            saveCurrentLoc["startlon"] = startPos?.coordinate.longitude
            saveCurrentLoc["endlat"] = endPos?.coordinate.latitude
            saveCurrentLoc["endlon"] = endPos?.coordinate.longitude
            saveCurrentLoc["km"] = kKmWakeup
            
            UserDefaults.standard.setValue(saveCurrentLoc, forKey: "saveCurrentLoc")
            
            textFieldActive.text = finalDestination
            
            updateUI()
        }
    }
    
    @IBAction func goRecent2(_ sender: Any) {
        var recentList = [[String : Any]]()
        
        if let savedList = UserDefaults.standard.array(forKey: "recents") as? [[String : Any]]
        {
            recentList = savedList
        }
        
        if(recentList.count > 1)
        {
            startPos = locationManager.location!
            endPos = CLLocation(latitude: recentList[1]["lat"] as! Double, longitude: recentList[1]["lon"] as! Double)
            
            finalDestination = recentList[1]["name"] as! String
            
            kKmWakeup = Int(kmTextfield.text!) ?? 0
            LocationNotification().postNotification(notificationMessage: "Gather your things, you're almost there..", loc: endPos!.coordinate, radius: Double(kKmWakeup))
            
            var saveCurrentLoc = [String : Any]()
            saveCurrentLoc["name"] = finalDestination
            saveCurrentLoc["startlat"] = startPos?.coordinate.latitude
            saveCurrentLoc["startlon"] = startPos?.coordinate.longitude
            saveCurrentLoc["endlat"] = endPos?.coordinate.latitude
            saveCurrentLoc["endlon"] = endPos?.coordinate.longitude
            saveCurrentLoc["km"] = kKmWakeup
            
            UserDefaults.standard.setValue(saveCurrentLoc, forKey: "saveCurrentLoc")
            
            textFieldActive.text = finalDestination
            
            updateUI()
        }
    }
    
    @IBAction func goRecent3(_ sender: Any) {
        var recentList = [[String : Any]]()
        
        if let savedList = UserDefaults.standard.array(forKey: "recents") as? [[String : Any]]
        {
            recentList = savedList
        }
        
        if(recentList.count > 2)
        {
            startPos = locationManager.location!
            endPos = CLLocation(latitude: recentList[2]["lat"] as! Double, longitude: recentList[2]["lon"] as! Double)
            
            finalDestination = recentList[2]["name"] as! String
            
            kKmWakeup = Int(kmTextfield.text!) ?? 0
            LocationNotification().postNotification(notificationMessage: "Gather your things, you're almost there..", loc: endPos!.coordinate, radius: Double(kKmWakeup))
            
            var saveCurrentLoc = [String : Any]()
            saveCurrentLoc["name"] = finalDestination
            saveCurrentLoc["startlat"] = startPos?.coordinate.latitude
            saveCurrentLoc["startlon"] = startPos?.coordinate.longitude
            saveCurrentLoc["endlat"] = endPos?.coordinate.latitude
            saveCurrentLoc["endlon"] = endPos?.coordinate.longitude
            saveCurrentLoc["km"] = kKmWakeup
            
            UserDefaults.standard.setValue(saveCurrentLoc, forKey: "saveCurrentLoc")
            
            textFieldActive.text = finalDestination
            
            updateUI()
        }
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
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeLocalization on track")
        
        if CLLocationManager.locationServicesEnabled() {
            print ("user location found")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations[0])
        updateUI()
        
    }
    
    
    @IBAction func enterDestination(_ sender: Any) {
        searchTableview.isHidden = false
        if let inputText = textFieldActive.text{
            
            let _: () = Trafiklab().loadFromServerURLSESSION(inputText) { result in
                
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
            
            print("query is now: \(textFieldActive.text!)")
            
        }
        
    }
    
    
    @IBAction func sliderValueChanged(_ sender: Any) {                              //connect slider to labels
        
    }
    //get userLocation
    
    func updateUI()
    {
        if let userLocation = locationManager.location
        {
            //print(userLocation)
            if(startPos != nil)
            
            {
                let totalDistance = endPos!.distance(from: startPos!)
                
                let distanceNow = endPos!.distance(from: userLocation)
                
                let percentDone = 1 - (distanceNow/totalDistance)
                
                slider._currentValue = 0 - (percentDone * 100)
                distanceLabel.text = "\(Int(distanceNow / 1000))km"
                percentLabel.text = "\(Int(percentDone * 100))%"
                
                
                kKmWakeup = Int(kmTextfield.text!) ?? 0
                kKmLeft = Int(distanceNow / 100)
                
                if (kKmLeft <= kKmWakeup) {
                    if let currentPlay  = userDefaults.value(forKey: "defaultAudio") as? String {
                        let url = Bundle.main.url(forResource: currentPlay, withExtension: "wav")
                        player = try! AVAudioPlayer(contentsOf: url!)
                        player?.play()
                        player!.numberOfLoops = -1
                        
                        
                        
                        
                        
                        let center = UNUserNotificationCenter.current()
                        center.getPendingNotificationRequests() { allpend in
                            print("ALLPENDING DONE")
                            for pend in allpend
                            {
                                print(pend.identifier)
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    //self.locationManager.stopUpdatingLocation()
                    
                    let notificationMessage = "You are now \(kmTextfield.text!) km from \(finalDestination). "
                    
                    let alert = UIAlertController(title: "Gather your things, you're almost there..", message: notificationMessage, preferredStyle: .alert)
                    
                    self.locationManager.stopUpdatingLocation()
                    
                    alert.addAction(UIAlertAction(title: "Kill audio", style: .default, handler: { action in
                        self.player?.stop()
                    }))
                    self.present(alert, animated: true)
                    
                    
                    
                }
                
            }
            
        }
        
    }
}


