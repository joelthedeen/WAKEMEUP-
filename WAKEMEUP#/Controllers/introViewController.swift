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
        
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(switchButton.isOn == false)
        {
            return
        }
        if(switchButton.isOn == true){
            performSegue(withIdentifier: "gomain", sender: nil)
        }
        else{
            return
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
