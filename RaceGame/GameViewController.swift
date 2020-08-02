//
//  GameViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/20/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var roadViewOutlet: UIView!
    @IBOutlet weak var transparentViewOutlet: UIView!
    var carImageView: UIImageView?
    let lineViewWidth: CGFloat = 20
    let lineViewHeight: CGFloat = 80
    let x = 0
    let y = 0
    //    let lineView = UIView()?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locateCar("yellow_car")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.roadLineView()
        })
        
        timer.fire()
    }
    @IBAction func pressedPauseButton(_ sender: UIButton) {
        
        //        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    private func roadLineView() {
        
        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
        let yHeight = UIScreen.main.bounds.height + lineViewHeight
        
        let lineView = UIView(frame: CGRect(x: lineViewCenterX, y: CGFloat(y), width: self.lineViewWidth, height: self.lineViewHeight))
        lineView.backgroundColor = .white
        roadViewOutlet.addSubview(lineView)
        
        self.viewAnimate(someView: lineView, x: lineViewCenterX, y: yHeight)
        
    }
    
    
    
    private func viewAnimate (someView: UIView, x: CGFloat, y: CGFloat){
       
            UIView.animate(withDuration: 1, animations: {
                someView.layer.position = CGPoint(x: x, y: y)
            }) {(_) in
            }
    }
    
    func locateCar(_ car: String) {
        
        guard var imageViewGuard = carImageView else {
            return
        }
        
        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
        let yHeight = UIScreen.main.bounds.height - imageViewGuard.bounds.height

        imageViewGuard = UIImageView(frame: CGRect(x: 0, y: 400, width: 400, height: 400))
        
//        carImageView = UIImageView(frame: CGRect(x: 400/*lineViewCenterX*/, y: 400/*yHeight*/, width: roadViewOutlet.bounds.width / 2, height: imageViewGuard.bounds.height))
        
//        carImageView?.image = UIImage(named: car)
        
        imageViewGuard.image = UIImage(named: car)
        roadViewOutlet.addSubview(imageViewGuard)
        
    }
    
    func moveCarToLeft() {
        
    }
    
    func moveCarToRight(){
        
    }
}
