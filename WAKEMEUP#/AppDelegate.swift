//
//  AppDelegate.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-10-14.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    /*
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let content = UNMutableNotificationContent()
        content.title = "Gather your things.."
        content.body = "APELSIN"

          var currentPlay = "WAKE1.wav"
        let userDefaults = UserDefaults.standard
          if let defaultPlay  = userDefaults.value(forKey: "defaultAudio") as? String {
              currentPlay = defaultPlay + ".wav"
          }
          
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: currentPlay))
        
          let id = "reminderX-\(UUID().uuidString)"
          
          
          
          let content2 = UNMutableNotificationContent()
          content2.title = "TID NOTIS"
          content2.body = "BANAN"

            
            
          content2.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: currentPlay))
          
          
          let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
          let request2 = UNNotificationRequest(identifier: id, content: content2, trigger: trigger2)
          center.add(request2, withCompletionHandler: { error in
           let main = OperationQueue.main
           main.addOperation {
            print("main.addOperation == true")
           }
          })
          
          
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        let content = UNMutableNotificationContent()
        content.title = "Gather your things.."
        content.body = "APELSIN2"

          var currentPlay = "WAKE1.wav"
        let userDefaults = UserDefaults.standard
          if let defaultPlay  = userDefaults.value(forKey: "defaultAudio") as? String {
              currentPlay = defaultPlay + ".wav"
          }
          
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: currentPlay))
        
          let id = "reminderX-\(UUID().uuidString)"
          
          
          
          let content2 = UNMutableNotificationContent()
          content2.title = "TID NOTIS"
          content2.body = "BANAN2"

            
            
          content2.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: currentPlay))
          
          
          let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
          let request2 = UNNotificationRequest(identifier: id, content: content2, trigger: trigger2)
          center.add(request2, withCompletionHandler: { error in
           let main = OperationQueue.main
           main.addOperation {
            print("main.addOperation == true")
           }
          })
          
        
    }
    */

}

