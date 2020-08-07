//
//  GameViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/20/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var carLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var roadViewOutlet: UIView!
    @IBOutlet weak var transparentViewOutlet: UIView!
    var treeImageView: UIImageView?
    var enemyImageView: UIImageView?
    let lineViewWidth: CGFloat = 20
    let lineViewHeight: CGFloat = 80
    let x = 0
    let y = 0
    let treeWidth = 10
    
    //    let lineView = UIView()?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locateCar()
        carLeadingConstraint.constant = 50
        
        addEnemy()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.roadLineView()
        })
        timer.fire()
  
        let panRec = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panRec)
        
//        let enemyTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
//            self.addEnemy()
//        })
//        enemyTimer.fire()
        
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
//        guard let centerImage: CGPoint = carImageView.center else {
//            return
//        }
        
        //        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
        //        let yHeight = UIScreen.main.bounds.height - imageViewGuard.bounds.height
        //
        
//        let frame = carImageView.bounds
        
//        let imageView = UIImageView(frame: frame)
//        imageView.contentMode = .scaleAspectFit
////        imageView.backgroundColor = .clear
        
        
        carImageView.image = Images.grey_car
        carImageView.backgroundColor = .clear
        carImageView.isOpaque = false
//
//        let center = centerImage
//        imageView.center = center
        
        
        //        carImageView = UIImageView(frame: CGRect(x: 400/*lineViewCenterX*/, y: 400/*yHeight*/, width: roadViewOutlet.bounds.width / 2, height: imageViewGuard.bounds.height))
        
        //        carImageView?.image = UIImage(named: car)
        
//        self.roadViewOutlet.addSubview(carImageView)
        
    }
    
    
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
   
        if gesture.state == .began || gesture.state == .changed {

            let translation = gesture.translation(in: self.view)
            print(carLeadingConstraint.constant)
            carLeadingConstraint.constant = translation.x
//            print(translation.x)

        }
    }
    
    
   
    
    func nukeAllAnimations() {
        roadViewOutlet.subviews.forEach({$0.layer.removeAllAnimations()})
        roadViewOutlet.layer.removeAllAnimations()
        roadViewOutlet.layoutIfNeeded()
    }
    
    
    func addTree(){
        
        guard let imageView = treeImageView else {
            return
        }
        
        //        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
        //        let yHeight = UIScreen.main.bounds.height - imageViewGuard.bounds.height
        //
        
        
        
        //                 imageView = UIImageView(frame: CGRect(x: , y: , width: <#T##CGFloat#>, height: <#T##CGFloat#>))
        imageView.contentMode = .scaleAspectFit
        imageView.isOpaque = false
        imageView.image = Images.yellow_car
        
        
        //        carImageView = UIImageView(frame: CGRect(x: 400/*lineViewCenterX*/, y: 400/*yHeight*/, width: roadViewOutlet.bounds.width / 2, height: imageViewGuard.bounds.height))
        
        //        carImageView?.image = UIImage(named: car)
        
        self.roadViewOutlet.addSubview(imageView)
        
        
    }
    
    func addEnemy() {
//        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
//        let yHeight = UIScreen.main.bounds.height + lineViewHeight
        
        let imageViewWidth = roadViewOutlet.frame.size.width - CGFloat(lineViewWidth)
        let imageViewHeight = roadViewOutlet.frame.size.height * 0.2
        
        if var enemy = enemyImageView  {
            enemy = UIImageView(frame: CGRect(x: 400, y: 200, width: imageViewWidth, height: imageViewHeight))
            enemy.image = Images.yellow_car
            enemy.contentMode = .scaleAspectFit
//            self.viewAnimate(someView: enemy)
            roadViewOutlet.addSubview(enemy)
        }
        
    }
    
}

