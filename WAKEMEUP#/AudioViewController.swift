//
//  AudioViewController.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-10.
//

import UIKit
import AVFoundation
import SCLAlertView



class AudioViewController: UIViewController {

    @IBOutlet weak var speaker1: UIButton!
    @IBOutlet weak var speaker2: UIButton!
    @IBOutlet weak var speaker3: UIButton!
    @IBOutlet weak var speaker4: UIButton!
    
    var soundActive: Bool = false
    var soundActive2: Bool = false
    var soundActive3: Bool = false
    var soundActive4: Bool = false
    var soundIsActive: Bool = false
    
    var currentPlay = "WAKE1"
    
    var player: AVAudioPlayer?
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        onloadDefaultAudio()

    }
    
    
    @IBAction func dismissAudioSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func toggle1(_ sender: Any) {
        if(soundActive == true)
        {
            return
        }
        soundActive = !soundActive
        toggleSoundForEachButton(sender, soundActive)
        setAllBoolToFalse(soundActive, "1")
        currentPlay = "WAKE1"
    }
    
    
    @IBAction func speaker2(_ sender: Any) {
        if(soundActive2 == true)
        {
            return
        }
        soundActive2 = !soundActive2
        toggleSoundForEachButton(sender, soundActive2 )
        setAllBoolToFalse(soundActive, "2")
        currentPlay = "WAKE2"
    }
    
    @IBAction func speaker3(_ sender: Any) {
        if(soundActive3 == true)
        {
            return
        }
        soundActive3 = !soundActive3
        toggleSoundForEachButton(sender,soundActive3 )
        setAllBoolToFalse(soundActive, "3")
        currentPlay = "WAKE3"
    }
    
    @IBAction func speaker4(_ sender: Any) {
        if(soundActive4 == true)
        {
            return
        }
        soundActive4 = !soundActive4
        toggleSoundForEachButton(sender, soundActive4)
        setAllBoolToFalse(soundActive, "4")
        currentPlay = "WAKE4"
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
            (button as AnyObject).setImage(#imageLiteral(resourceName: "soundOn"), for: .normal)
          print("soundOn")
        } else {
            (button as AnyObject).setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            print("soundOff")
        }

    }
    
    
    func setAllBoolToFalse(_ isSound: Bool, _ isButton:String) {
        
        
        switch isButton {
        case "1":
            print(isSound)
            soundActive2 = false
            speaker2.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive3 = false
            speaker3.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive4 = false
            speaker4.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
        case "2":
            print(isSound)
            soundActive = false
            speaker1.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive3 = false
            speaker3.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive4 = false
            speaker4.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
        case "3":
            print(isSound)
            soundActive2 = false
            speaker2.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive = false
            speaker1.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive4 = false
            speaker4.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
        case "4":
            print(isSound)
            soundActive2 = false
            speaker2.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive3 = false
            speaker3.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
            soundActive = false
            speaker1.setImage(#imageLiteral(resourceName: "soundOff"), for: .normal)
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
                speaker1.setImage(#imageLiteral(resourceName: "soundOn"), for: .normal)
            case  "WAKE2":
                speaker2.setImage(#imageLiteral(resourceName: "soundOn"), for: .normal)
            case  "WAKE3":
                speaker3.setImage(#imageLiteral(resourceName: "soundOn"), for: .normal)
            case  "WAKE4":
                speaker4.setImage(#imageLiteral(resourceName: "soundOn"), for: .normal)
            default:
                return
            }
           
         }
    }
    
}
