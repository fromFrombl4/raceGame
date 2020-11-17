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
    
    private enum Direction {
        case right
        case left
    }
        
    
    private enum RoadConstants {
        static let roadCycle: TimeInterval = 2
        static let lineWidth: CGFloat = 20
        static let lineHeight: CGFloat = 80
    }
    
    private enum ConeConstants {
        static let coneCycle: TimeInterval = 2
        static let coneWidth: CGFloat = 20
        static let coneHeight: CGFloat = 80
    }
    
    @IBOutlet weak var carLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var roadViewOutlet: UIView!
    @IBOutlet weak var transparentViewOutlet: UIView!
    
    var roadLineView: UIView!
    var roadAnimatedCount = 0
    var roadDistance: CGFloat = 0.0
    var roadVelocity: CGFloat = 0.0
    
    var treeImageView = UIImageView()
    var enemyImageView = UIImageView()
    var scoresLabel = UILabel()
    
    let x = 0
    let y = 0
    let treeWidth = 10
    var scores = 0
    
    var time: TimeInterval = 0.0
    var initialInterval: TimeInterval!
    
    
    
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
        
        createRoadView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initialInterval = Date.timeIntervalSinceReferenceDate
        
        //        let timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true, block: {_ in
        //            self.roadLineView()
        //        })
        //        timer.fire()
        
//        let panRec = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        view.addGestureRecognizer(panRec)
        
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe(_:)))
        swipeLeftRecognizer.direction = .left
        roadViewOutlet.addGestureRecognizer(swipeLeftRecognizer)
        
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe(_:)))
        swipeRightRecognizer.direction = .right
        roadViewOutlet.addGestureRecognizer(swipeRightRecognizer)
        
                self.addEnemy()
        
        let tikTimer = Timer.scheduledTimer(timeInterval: 1.0/120.0, target: self, selector: #selector(tik), userInfo: nil, repeats: true)
        tikTimer.fire()

        //        let instersectsTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: {_ in
        //            self.calculateIntersects(self.carImageView, self.enemyImageView)
        //        })
        //        instersectsTimer.fire()
        
        calculateValues()
    }
    
    private func calculateValues() {
        roadDistance = view.bounds.height + RoadConstants.lineHeight
        roadVelocity = roadDistance / CGFloat(RoadConstants.roadCycle)
    }
    
    @IBAction func pressedPauseButton(_ sender: UIButton) {
        
        //        self.navigationController?.popViewController(animated: true)
        
    }
    
    fileprivate func createRoadView() {
        roadLineView = UIView(frame: CGRect(x: view.center.x - 3 * RoadConstants.lineWidth,
                                            y: 0 - RoadConstants.lineHeight,
                                            width: RoadConstants.lineWidth,
                                            height: RoadConstants.lineHeight))
        roadLineView.backgroundColor = .white
        roadViewOutlet.insertSubview(roadLineView, at: 0)
    }
    
    private func moveRoadViewToTop() {
        roadLineView.frame.origin.y = -RoadConstants.lineHeight
    }
    
    private func updateRoadView(_ time: TimeInterval) {
        let relativeTime = time - TimeInterval(roadAnimatedCount) * RoadConstants.roadCycle
        roadLineView.frame.origin.y = roadVelocity * CGFloat(relativeTime) - RoadConstants.lineHeight
    }
    
    private func moveEnemyViewToTop() {
        enemyImageView.frame.origin.y = -ConeConstants.coneHeight
    }
    
//    private func updateConeView(_ time: TimeInterval) {
//        let relativeTime = time - TimeInterval(roadAnimatedCount) * RoadConstants.roadCycle
//        roadLineView.frame.origin.y = roadVelocity * CGFloat(relativeTime) - RoadConstants.lineHeight
//    }
    
    //    private func updateEnemyView(_ time: TimeInterval) {
    //        let relativeTime = time - TimeInterval(
    //    }
    
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
    
    
//
//    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
//        if gesture.state == .began || gesture.state == .changed {
//            let translation = gesture.translation(in: self.view)
//            //            print(carLeadingConstraint.constant)
//            carLeadingConstraint.constant = translation.x
//        }
//    }
    
    @objc func handleLeftSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        carLeadingConstraint.constant -= 50
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.layoutIfNeeded()
        }) { (_) in
        }
    }
    @objc func handleRightSwipe(_ gesture: UISwipeGestureRecognizer) {

        carLeadingConstraint.constant += 50
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.layoutIfNeeded()
        }) { (_) in
        }
    }
    
    
    
    
    func nukeAllAnimations() {
        roadViewOutlet.subviews.forEach({$0.layer.removeAllAnimations()})
        roadViewOutlet.layer.removeAllAnimations()
        roadViewOutlet.layoutIfNeeded()
    }
    
    
    func addTree(){
        treeImageView.contentMode = .scaleAspectFit
        treeImageView.isOpaque = false
        treeImageView.image = Images.yellow_car
        
        self.roadViewOutlet.addSubview(treeImageView)
    }
    
    func addEnemy() {
        let imageViewWidth = roadViewOutlet.frame.size.width * 0.2
        let imageViewHeight = roadViewOutlet.frame.size.height * 0.2
        enemyImageView = UIImageView(frame: CGRect(x: CGFloat.random(in: roadViewOutlet.frame.origin.x ... roadViewOutlet.frame.origin.x - enemyImageView.frame.size.width ), y: 100, width: imageViewWidth, height: imageViewHeight))
        enemyImageView.image = Images.cone1
        enemyImageView.contentMode = .scaleAspectFit
//        animateEnemy()
        roadViewOutlet.addSubview(enemyImageView)
       
        
    }
    
    func calculateIntersects(_ carImageView: UIImageView, _ enemyImageView: UIImageView) {
        
        if carImageView.frame.intersects(enemyImageView.frame){
            self.nukeAllAnimations()
        }
        print("\(enemyImageView.frame)" + "&" + "\(carImageView.frame)")
    }
    
    func addScoresLabel(){
        scoresLabel = UILabel(frame: CGRect(x: 200, y: 70, width: roadViewOutlet.frame.size.width * 0.5, height: scoresLabel.contentScaleFactor))
        scoresLabel.backgroundColor = .brown
        scoresLabel.layer.borderWidth = 2
        scoresLabel.layer.borderColor = UIColor.black.cgColor
        
        let font = UIFont(name: "GreatVibes-Regular", size: 20)
        self.scoresLabel.font = font
        self.scoresLabel.textAlignment = .center
        self.scoresLabel.textColor = .white
        self.scoresLabel.text = "Name: \(UserDefaults.standard.value(forKey: "nickName") as! String) Score \(scores)"
        
        roadViewOutlet.addSubview(scoresLabel)
        
    }
    
    @objc func tik() {
        time = Date.timeIntervalSinceReferenceDate - initialInterval
//        print(time)
        
        updateRoadView(time)
        
        //0    0         - add road
        //0.016 0        - animate
        //0.032 0        - animate
        
        //0.32 / 1      0
        
        // 1.00 / 1.5 ?   1           -
        // 1.016 / 1 ?  1
        
        // 2.03 /2      2
        
        let roadCount = Int(time / RoadConstants.roadCycle)
        if roadCount > roadAnimatedCount {
            moveRoadViewToTop()
            roadAnimatedCount += 1
        }
        //        print(roadAnimatedCount)
        //        print(roadDistance)
        //        print(roadVelocity)
    }
    
    private func updateEnemyView(_ time: TimeInterval) {
        let relativeTime = time - TimeInterval(roadAnimatedCount) * ConeConstants.coneCycle
        roadLineView.frame.origin.y = roadVelocity * CGFloat(relativeTime) - ConeConstants.coneHeight
    }
    
    func obstructionTik(){
        time = Date.timeIntervalSinceReferenceDate - initialInterval
        updateEnemyView(time)
        
        let roadCount = Int(time / ConeConstants.coneCycle)
        if roadCount > roadAnimatedCount {
            moveRoadViewToTop()
            roadAnimatedCount += 1
    }
    
    func roadTik() {
        
    }
    
    
    
    func animateEnemy() {
        
    }
    
    func intersectEnemy() {
        
    }
}
}
