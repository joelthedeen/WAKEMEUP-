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
import SCLAlertView



class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var slider: MSCircularSlider!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var textFieldActive: UITextField!
    @IBOutlet weak var kmTextfield: UITextField!
    @IBOutlet weak var searchTableview: UITableView!
    
    
    @IBOutlet weak var recentButton1: UIButton!
    @IBOutlet weak var recentButton2: UIButton!
    @IBOutlet weak var recentButton3: UIButton!
    
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
    
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       locationManager = CLLocationManager()
       locationManager.requestAlwaysAuthorization()
       locationManager.requestWhenInUseAuthorization()
       locationManager.delegate = self
        
        //searchTableview.isHidden = true 
        
        //kKmWakeup = Int(kmTextfield.text!) ?? 0
        
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
        
        startPos = locationManager.location!
        endPos = CLLocation(latitude: chosenStop.lat, longitude: chosenStop.lon)

        updateUI()
        textFieldActive.text = stopResult!.StopLocation[indexPath.row].name
        searchTableview.isHidden = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
            recentButton1.setTitle(recentList[0]["name"] as! String, for: .normal)
        }
        if(recentList.count > 1)
        {
            recentButton2.setTitle(recentList[1]["name"] as! String, for: .normal)
        }
        if(recentList.count > 2)
        {
            recentButton3.setTitle(recentList[2]["name"] as! String, for: .normal)
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
        searchTableview.isHidden = false
        if let inputText = textFieldActive.text{
            
            let res: () = Trafiklab().loadFromServerURLSESSION(inputText) { result in
                
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
                let totalDistance = endPos!.distance(from: startPos!)
                
                let distanceNow = endPos!.distance(from: userLocation)
                
                let percentDone = 1 - (distanceNow/totalDistance)
                
                slider._currentValue = 100 - (percentDone * 100)
                distanceLabel.text = "\(Int(distanceNow / 1000))km"
                percentLabel.text = "\(Int(percentDone * 100))%"
                
                
                kKmWakeup = Int(kmTextfield.text!) ?? 0
                kKmLeft = Int(distanceNow / 1000)
      
               if (kKmLeft <= kKmWakeup) {
                    if let currentPlay  = userDefaults.value(forKey: "defaultAudio") as? String {
                        let url = Bundle.main.url(forResource: currentPlay, withExtension: "wav")
                        player = try! AVAudioPlayer(contentsOf: url!)
                        player?.play()
                        
                        
                        let alert = UIAlertController(title: "Time to wake up", message: "You are now \(kmTextfield.text ?? "empty") km from \(finalDestination)", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            self.player?.stop()
                        }))
                        self.present(alert, animated: true)
                        
                        
                      }
                    
                }
               
                
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
    

