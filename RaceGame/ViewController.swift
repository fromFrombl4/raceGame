//
//  ViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/20/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startGameLabel: UILabel!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var scores: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        let fonr = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        startGame.setRadiusWithShadow(30)
        settings.setRadiusWithShadow(30)
        scores.setRadiusWithShadow(30)
    }
    @IBAction func pressedStartGameButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Hi!", message: "Please, enter your name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            
            UserDefaults.standard.set(textField?.text, forKey: "nickName")
            
            guard let startGameController = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
            }
            self.navigationController?.pushViewController(startGameController, animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
       
        
        //        self.present(startGameController, animated: true, completion: nil)
        
    }
    @IBAction func pressedSettingsButton(_ sender: UIButton) {
        
        guard let settingsController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        
        //        self.present(settingsController, animated: true, completion: nil)
        self.navigationController?.pushViewController(settingsController, animated: true)
    }
    @IBAction func pressedScoresButton(_ sender: UIButton) {
        
        guard let scoresController = self.storyboard?.instantiateViewController(withIdentifier: "ScoresViewController") as? ScoresViewController else {
            return
        }
        
        self.navigationController?.pushViewController(scoresController, animated: true)
    }
    
    
}

extension UIView{
    
    func setRadiusWithShadow(_ radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? self.frame.width / 2
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 2)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
    }
}
