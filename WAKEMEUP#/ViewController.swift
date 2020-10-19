//
//  ViewController.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-10-14.
//

import UIKit
import MSCircularSlider


class ViewController: UIViewController {

    let soundBtnOn = UIImage(named: "soundOn")! as UIImage
    let soundBtnOff = UIImage(named: "soundOff")! as UIImage
    var soundActive: Bool = false
   
    

    @IBOutlet weak var soundBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        
        let frame = CGRect(x: view.center.x - 200, y: view.center.y - 200, width: 400, height: 400)     // center in superview
        let slider = MSCircularSlider(frame: frame, primaryAction: <#UIAction?#>)
        slider.currentValue = 60.0
        slider.maximumAngle = 300.0
        slider.filledColor = UIColor(red: 127 / 255.0, green: 168 / 255.0, blue: 198 / 255.0, alpha: 1.0)
        slider.unfilledColor = UIColor(red: 80 / 255.0, green: 148 / 255.0, blue: 95 / 255.0, alpha: 1.0)
        slider.handleType = .doubleCircle
        slider.handleColor = UIColor(red: 35 / 255.0, green: 69 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        slider.handleEnlargementPoints = 12
        slider.labels = ["1", "2", "3", "4", "5"]
        view.addSubview(slider)
       */
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {     //Keyboard hide
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
      }
    
    @IBAction func toggleSound(_ sender: Any) {
        

        soundActive = !soundActive
        
        if soundActive {
            soundBtn.setImage(soundBtnOn, for: .normal)
          print("soundOn")
        } else {
            soundBtn.setImage(soundBtnOff, for: .normal)
            print("soundOff")
        }
    }
   
}

