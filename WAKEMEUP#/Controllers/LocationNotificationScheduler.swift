//
//  LocationNotificationScheduler.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-20.
//

import UIKit
import UserNotifications
import CoreLocation

class Notification {
    
    let userDefaults = UserDefaults.standard
    
    func getAuthorization() {
      print(">> postNotification")
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
    func postNotification(notificationMessage : String, locX : CLLocationCoordinate2D, radius : Double) {
      
        let loc = CLLocationCoordinate2D(latitude: 55.611398, longitude: 12.994678)
        
        
        print(">> postNotification \(radius)")
        print(loc)
      let content = UNMutableNotificationContent()
      content.title = "Gather your things.."
      content.body = notificationMessage
        content.badge = 8

        var currentPlay = "WAKE1.wav"
        if let defaultPlay  = userDefaults.value(forKey: "defaultAudio") as? String {
            currentPlay = defaultPlay + ".wav"
        }
        
      content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: currentPlay))
      
        let id = "reminder-\(UUID().uuidString)"
        
        let destRegion = CLCircularRegion(center: loc,
                                          radius: 2000,
                                                  identifier: id)
        destRegion.notifyOnEntry = true
        destRegion.notifyOnExit = true
        let trigger = UNLocationNotificationTrigger(region: destRegion, repeats: true)
                
        
        
        
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
      
      let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
      let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        
        center.getPendingNotificationRequests() { allpend in
            print("ALLPENDING")
            for pend in allpend
            {
                print(pend.identifier)
                
            }
        }
        
        
      center.add(request, withCompletionHandler: { error in
        print("NOTIFADD")
        print(error.debugDescription)


        let main = OperationQueue.main
       main.addOperation {
        print("main.addOperation == true")
       }
      })
        

    
        
        
        
        
        
        
        
        
        
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
        
    }

}
