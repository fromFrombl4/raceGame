//
//  GameViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/20/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var carLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var roadViewOutlet: UIView!
    @IBOutlet weak var transparentViewOutlet: UIView!
    var treeImageView = UIImageView()
    var enemyImageView = UIImageView()
    var scoresLabel = UILabel()
    let lineViewWidth: CGFloat = 20
    let lineViewHeight: CGFloat = 80
    let x = 0
    let y = 0
    let treeWidth = 10
    var scores = 0
    
    
    //    let lineView = UIView()?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
        
        locateCar()
        carLeadingConstraint.constant = 50
        addScoresLabel()
        
        
//        enemyImageView = UIImageView(frame: CGRect(x: 200, y: 100, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height * 0.2))
//        enemyImageView.image = Images.yellow_car
//        roadViewOutlet.addSubview(enemyImageView)
        
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true, block: {_ in
            self.roadLineView()
        })
        timer.fire()
  
        let panRec = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panRec)
        
        let enemyTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {_ in
            self.addEnemy()
        })
        enemyTimer.fire()
        
        let instersectsTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: {_ in
            self.calculateIntersects(self.carImageView, self.enemyImageView)
        })
        instersectsTimer.fire()
        
    }
    
   
    @IBAction func pressedPauseButton(_ sender: UIButton) {
        
        //        self.navigationController?.popViewController(animated: true)

    }
    
    private func roadLineView() {
        
        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
        let yHeight = UIScreen.main.bounds.height + lineViewHeight
        
        let lineView = UIView(frame: CGRect(x: lineViewCenterX, y: CGFloat(y), width: self.lineViewWidth, height: self.lineViewHeight))
        lineView.backgroundColor = .white
        roadViewOutlet.insertSubview(lineView, at: 0)
        
        self.viewAnimate(someView: lineView)
        
    }
    
    
    
    private func viewAnimate (someView: UIView){
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
//            someView.layer.position = CGPoint(x: x, y: y)
            someView.frame.origin.y += 1000
        }) {(_) in
            
            someView.removeFromSuperview()
        }
    }
    
    func locateCar() {
        carImageView.image = Images.mercedes
        carImageView.transform = carImageView.transform.rotated(by: .pi/2)
        carImageView.backgroundColor = .clear
        carImageView.isOpaque = false
        
    }
    
    
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
   
        if gesture.state == .began || gesture.state == .changed {

            let translation = gesture.translation(in: self.view)
            print(carLeadingConstraint.constant)
            carLeadingConstraint.constant = translation.x
            
            

        }

//        if carImageView.frame.origin.x <= 0 || carImageView.frame.origin.x >= roadViewOutlet.frame.origin.x{
//            nukeAllAnimations()
//        }
    }
    
    
   
    
    func nukeAllAnimations() {
        roadViewOutlet.subviews.forEach({$0.layer.removeAllAnimations()})
        roadViewOutlet.layer.removeAllAnimations()
        roadViewOutlet.layoutIfNeeded()
    }
    
    
    func addTree(){
        
        //        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
        //        let yHeight = UIScreen.main.bounds.height - imageViewGuard.bounds.height
        //
        
        
        
        //                 treeImageView = UIImageView(frame: CGRect(x: , y: , width: <#T##CGFloat#>, height: <#T##CGFloat#>))
        treeImageView.contentMode = .scaleAspectFit
        treeImageView.isOpaque = false
        treeImageView.image = Images.yellow_car
        
        self.roadViewOutlet.addSubview(treeImageView)
        
        
    }
    
    func addEnemy() {
        let imageViewWidth = roadViewOutlet.frame.size.width - CGFloat(lineViewWidth)
        let imageViewHeight = roadViewOutlet.frame.size.height * 0.15
        
        enemyImageView = UIImageView(frame: CGRect(x: 100, y: 20, width: imageViewWidth, height: imageViewHeight))
        enemyImageView.image = Images.police
        enemyImageView.transform = enemyImageView.transform.rotated(by: .pi * 1.5)
            enemyImageView.contentMode = .scaleAspectFit
            self.viewAnimate(someView: enemyImageView)
            roadViewOutlet.insertSubview(enemyImageView, at: 1)
        
    }
    
    func calculateIntersects(_ carImageView: UIImageView, _ enemyImageView: UIImageView) {
        
        if carImageView.frame.intersects(enemyImageView.frame){
            self.nukeAllAnimations()
        }
    }
    
    func addScoresLabel(){
        scoresLabel = UILabel(frame: CGRect(x: 200, y: 50, width: 100, height: 50))
        scoresLabel.backgroundColor = .brown
        scoresLabel.layer.borderWidth = 2
        scoresLabel.layer.borderColor = UIColor.black.cgColor
        
        let font = UIFont(name: "GreatVibes-Regular", size: 20)
        self.scoresLabel.font = font
        self.scoresLabel.textAlignment = .center
        self.scoresLabel.textColor = .white
        self.scoresLabel.text = "Score \(scores)"
        
        roadViewOutlet.addSubview(scoresLabel)
        
        
    }
    
}

