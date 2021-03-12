//
//  introViewController.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-18.
//

import UIKit

var userDefaultDontshowAgain = UserDefaults.standard

class introViewController: UIViewController {

    @IBOutlet weak var switchButton: UISwitch!
    var switchButtonOn: Bool = false
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if(switchButton.isOn == false)
        {
            return
        }
        if(switchButton.isOn == true)
        {
            performSegue(withIdentifier: "gomain", sender: nil)
        }
        else{
            return
        }
    }
}
