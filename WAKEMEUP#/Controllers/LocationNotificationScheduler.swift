//
//  LocationNotificationScheduler.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-20.
//

import UIKit
import UserNotifications
import CoreLocation

class LocationNotification: NSObject, UNUserNotificationCenterDelegate {
    
    let userDefaults = UserDefaults.standard

    override init()
    {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        getAuthorization()
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
    
    func postNotification(notificationMessage : String, loc : CLLocationCoordinate2D, radius : Double) {
        
        
        
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
        
        let destRegion = CLCircularRegion(center: loc,
                                          radius: CLLocationDistance(radius),
                                          identifier: id)
        destRegion.notifyOnEntry = true
        destRegion.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: destRegion, repeats: false)
        
        
        
        
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        
        center.add(request, withCompletionHandler: { error in
            print("NOTIFICATION SCHEDULED")
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
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    }
    
}
















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




