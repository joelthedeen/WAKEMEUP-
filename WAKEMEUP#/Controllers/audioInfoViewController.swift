//
//  audioInfoViewController.swift
//  WAKEMEUP#
//
//  Created by Joel Thedéen on 2020-11-18.
//

import UIKit

class audioInfoViewController: UIViewController {

    @IBAction func goToSpotify(_ sender: Any) {
        if let url = URL(string: "https://open.spotify.com/artist/5qAZ4282r6G4jhhjMIgSB9?utm_source=spotify_crm&utm_medium=2017q4&utm_campaign=2017q4_global_global_alwayson_free_onboarding_2make_playlist&gtm=1&fo=1") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
