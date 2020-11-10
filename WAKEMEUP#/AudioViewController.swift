//
//  AudioViewController.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-10.
//

import UIKit




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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Exempel checkbox toggle ON/OFF
    //soundBtnOn/Off bildfiler
    //soundBtn namn på button (outlet)
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
            print("dick")
        }
    }

            
    @IBAction func toggle1(_ sender: Any) {
        soundActive = !soundActive
        toggleSoundForEachButton(sender, soundActive)
        setAllBoolToFalse(soundActive, "1")
        }
    
    
    @IBAction func speaker2(_ sender: Any) {
        soundActive2 = !soundActive2
        toggleSoundForEachButton(sender, soundActive2 )
        setAllBoolToFalse(soundActive, "2")
    }
    
    @IBAction func speaker3(_ sender: Any) {
        soundActive3 = !soundActive3
        toggleSoundForEachButton(sender,soundActive3 )
        setAllBoolToFalse(soundActive, "3")
    }
    
    @IBAction func speaker4(_ sender: Any) {
        soundActive4 = !soundActive4
        toggleSoundForEachButton(sender, soundActive4)
        setAllBoolToFalse(soundActive, "4")
    }
    
    
}



