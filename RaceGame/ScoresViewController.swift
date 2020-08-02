//
//  ScoresViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/21/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressedBackButton(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
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
