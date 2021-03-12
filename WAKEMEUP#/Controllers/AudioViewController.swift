//
//  AudioViewController.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-10.
//

import UIKit
import AVFoundation



class AudioViewController: UIViewController {
    
    
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var bckgImage: UIImageView!
    
    var soundActive: Bool = false
    var soundActive2: Bool = false
    var soundActive3: Bool = false
    var soundActive4: Bool = false
    var soundIsActive: Bool = false
    
    
    var currentPlay = "WAKE3"
    
    var player: AVAudioPlayer?
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch1.setOn(!switch1.isOn, animated: false)
        switch2.setOn(!switch2.isOn, animated: false)
        switch3.setOn(!switch3.isOn, animated: false)
        switch4.setOn(!switch4.isOn, animated: false)
        // Do any additional setup after loading the view.
        onloadDefaultAudio()
        
    
        
    }
    
    
    @IBAction func dismissAudioSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchSound1(_ sender: Any) {
        currentPlay = ""
        
        switch2.isOn = false
        switch3.isOn = false
        switch4.isOn = false
        
        player?.stop()
        
        if(switch1.isOn == true)
        {
            PlaySound(currentPlay: "WAKE1")
            currentPlay = "WAKE1"
        }
        
    }
    
    @IBAction func switchSound2(_ sender: Any) {
        currentPlay = ""
        
        switch1.isOn = false
        switch3.isOn = false
        switch4.isOn = false
        
        player?.stop()
        
        if(switch2.isOn == true)
        {
            PlaySound(currentPlay: "WAKE2")
            currentPlay = "WAKE2"
        }
        
    }
    
    
    @IBAction func switchSound3(_ sender: Any) {
        currentPlay = ""
        
        switch2.isOn = false
        switch1.isOn = false
        switch4.isOn = false
        
        player?.stop()
        
        if(switch3.isOn == true)
        {
            PlaySound(currentPlay: "WAKE3")
            currentPlay = "WAKE3"
        }
        
    }
    
    @IBAction func switchSound4(_ sender: Any) {
        
        currentPlay = ""
        
        switch2.isOn = false
        switch3.isOn = false
        switch1.isOn = false
        
        player?.stop()
        
        if(switch4.isOn == true)
        {
            PlaySound(currentPlay: "WAKE4")
            currentPlay = "WAKE4"
        }
        
    }
    
    
    @IBAction func audio1(_ sender: Any) {
        PlaySound(currentPlay: "WAKE1")
    }
    
    @IBAction func audio2(_ sender: Any) {
        PlaySound(currentPlay: "WAKE2")
    }
    
    @IBAction func audio3(_ sender: Any) {
        PlaySound(currentPlay: "WAKE3")
    }
    
    @IBAction func audio4(_ sender: Any) {
        PlaySound(currentPlay: "WAKE4")
    }
    
    
    @IBAction func setToDefaultBntPress(_ sender: Any) {
        saveUserDefault(defaultAudio: currentPlay, setForKey: "defaultAudio")
        dismiss(animated: true, completion: nil)
    }
    
    //Toggle buttons
    func toggleSoundForEachButton(_ button: Any, _ soundIsActive: Bool) {
        
        if soundIsActive  {
            switch1.isOn = true
            //   (button as AnyObject).setImage(#imageLiteral(resourceName: "soundOn"), for: .normal)
            print("soundOn")
        } else {
            switch1.isOn = false
            // (button as AnyObject).setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            print("soundOff")
        }
        
    }
    
    
    func setAllBoolToFalse(_ isSound: Bool, _ isButton:String) {
        
        
        switch isButton {
        case "1":
            
            switch2.setOn(!switch2.isOn, animated: true)
            soundActive2 = false
            switch3.setOn(!switch3.isOn, animated: true)
            soundActive3 = false
            switch4.setOn(!switch4.isOn, animated: true)
            soundActive4 = false
            
        case "2":
            switch1.setOn(!switch1.isOn, animated: true)
            soundActive = false
            switch3.setOn(!switch3.isOn, animated: true)
            soundActive3 = false
            switch4.setOn(!switch4.isOn, animated: true)
            soundActive4 = false
            
        case "3":
            switch1.setOn(!switch1.isOn, animated: true)
            soundActive = false
            switch2.setOn(!switch2.isOn, animated: true)
            soundActive2 = false
            switch4.setOn(!switch4.isOn, animated: true)
            soundActive4 = false
            
        case "4":
            switch1.setOn(!switch1.isOn, animated: true)
            soundActive = false
            switch3.setOn(!switch3.isOn, animated: true)
            soundActive3 = false
            switch2.setOn(!switch2.isOn, animated: false)
            soundActive2 = false
            
        default:
            print("test")
        }
    }
    
    private func PlaySound(currentPlay: String!){
        let url = Bundle.main.url(forResource: currentPlay, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
        
    }
    
    
    
    
    private func saveUserDefault(defaultAudio: String, setForKey: String){
        userDefaults.setValue(defaultAudio , forKey: setForKey)
        userDefaults.synchronize()
    }
    
    private func onloadDefaultAudio(){
        print("onloadDefaultAudio")
        if let defaultAudio  = userDefaults.value(forKey: "defaultAudio") as? String {
            print(defaultAudio)
            switch defaultAudio {
            case  "WAKE1":
                switch1.isOn = true
            case  "WAKE2":
                switch2.isOn = true
            case  "WAKE3":
                switch3.isOn = true
            case  "WAKE4":
                switch4.isOn = true
            default:
                return
            }
        }
    }
}
