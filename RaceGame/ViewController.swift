//
//  ViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/20/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var scores: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func pressedStartGameButton(_ sender: UIButton) {
        
        let startGameController = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
//        self.present(startGameController, animated: true, completion: nil)
        self.navigationController?.pushViewController(startGameController, animated: true)
    }
    @IBAction func pressedSettingsButton(_ sender: UIButton) {
        
        let settingsController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
//        self.present(settingsController, animated: true, completion: nil)
        self.navigationController?.pushViewController(settingsController, animated: true)
    }
    @IBAction func pressedScoresButton(_ sender: UIButton) {
        
        let scoresController = self.storyboard?.instantiateViewController(withIdentifier: "ScoresViewController") as! ScoresViewController
        
        self.navigationController?.pushViewController(scoresController, animated: true)
    }
    

}

