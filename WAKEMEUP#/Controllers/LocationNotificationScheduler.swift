//
//  LocationNotificationScheduler.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-20.
//

import UIKit
import UserNotifications
import CoreLocation

class LocationNotification: UIViewController, UNUserNotificationCenterDelegate {
    
    var locationManager = CLLocationManager()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
        UNUserNotificationCenter.current().delegate = self
    }
    func getAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler: { settings in
            if settings.authorizationStatus == .authorized {
                print(" Yes > if settings.authorizationStatus == .authorized")
            } else {
                center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
                    if granted && error == nil {
                        print("Yes > granted && error == nil")
                    } else {
                        print("NOT >granted && error == nil")
                    }
                })
            }
        })
    }
    //    func getAuthorization() {
    //      print(">> postNotification")
    //      let center = UNUserNotificationCenter.current()
    //      center.getNotificationSettings(completionHandler: { settings in
    //       if settings.authorizationStatus == .authorized {
    //         print(" Yes > if settings.authorizationStatus == .authorized")
    //       } else {
    //        center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
    //          if granted && error == nil {
    //            print("Yes > granted && error == nil")
    //          } else {
    //            print("NOT >granted && error == nil")
    //          }
    //         })
    //       }
    //      })
    //}
    func postNotification(notificationMessage : String, loc : CLLocationCoordinate2D, radius : Double) {
        
        //let loc = CLLocationCoordinate2D(latitude: 55.611398, longitude: 12.994678)
        
        
        print(">> postNotification \(radius)")
        print(loc)
        
        let content = UNMutableNotificationContent()
        content.title = "Almost there.."
        content.body = notificationMessage
        content.badge = 1
        
        var currentPlay = "WAKE1.wav"
        if let defaultPlay  = userDefaults.value(forKey: "defaultAudio") as? String {
            currentPlay = defaultPlay + ".wav"
        }
        
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: currentPlay))
        
        let id = "reminder-\(UUID().uuidString)"
        print(locationManager.location!.coordinate)
        
        let destRegion = CLCircularRegion(center: locationManager.location!.coordinate,
                                          radius: 100,
                                          identifier: id)
        destRegion.notifyOnEntry = true
        destRegion.notifyOnExit = true
        let trigger = UNLocationNotificationTrigger(region: destRegion, repeats: true)
        
        
        
        
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        //center.removeAllPendingNotificationRequests()
        
        center.add(request, withCompletionHandler: { error in
            print("NOTIFADD")
            print(error.debugDescription)
            
            center.getPendingNotificationRequests() { allpend in
                print("ALLPENDING DONE")
                for pend in allpend
                {
                    print(pend.identifier)
                    
                }
            }
            DispatchQueue.main.async {
                
            }
            
        })
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "Alert", message: "didReceive", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        let alert = UIAlertController(title: "Alert", message: "WILL PRESENT", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}





//        let main = OperationQueue.main
//       main.addOperation {
//        print("main.addOperation == true")
//       }













/*
 let content2 = UNMutableNotificationContent()
 content2.title = "TID NOTIS"
 content2.body = notificationMessage
 
 
 
 content2.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: currentPlay))
 
 
 let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
 let request2 = UNNotificationRequest(identifier: id, content: content2, trigger: trigger2)
 center.add(request2, withCompletionHandler: { error in
 let main = OperationQueue.main
 main.addOperation {
 print("main.addOperation == true")
 }
 })
 
 */




