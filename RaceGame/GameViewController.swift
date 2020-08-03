//
//  GameViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/20/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var roadViewOutlet: UIView!
    @IBOutlet weak var transparentViewOutlet: UIView!
//    var carImageView: UIImageView?
    let lineViewWidth: CGFloat = 20
    let lineViewHeight: CGFloat = 80
    let x = 0
    let y = 0
    //    let lineView = UIView()?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         locateCar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.roadLineView()
        })
        
        timer.fire()
        
        
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(handleLeftTap))
        tapLeft.numberOfTapsRequired = 1
        tapLeft.numberOfTouchesRequired = 1
        
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(handleRightTap))
        tapRight.numberOfTouchesRequired = 1
        tapRight.numberOfTapsRequired = 1
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
    
    func locateCar() {
        guard let centerImage: CGPoint = carImageView.center else {
            return
        }
//        guard var imageView = carImageView else {
//            return
//        }
        
//        let lineViewCenterX:CGFloat = roadViewOutlet.frame.size.width / 2 - CGFloat(lineViewWidth)/2
//        let yHeight = UIScreen.main.bounds.height - imageViewGuard.bounds.height
//
//        imageView = UIImageView(frame: CGRect(x: 0, y: 400, width: 400, height: 400))
        let frame = carImageView.bounds
        
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .none
        imageView.image = Images.yellow_car
        
        let center = centerImage
        imageView.center = center
//        carImageView = UIImageView(frame: CGRect(x: 400/*lineViewCenterX*/, y: 400/*yHeight*/, width: roadViewOutlet.bounds.width / 2, height: imageViewGuard.bounds.height))
        
//        carImageView?.image = UIImage(named: car)

        self.roadViewOutlet.addSubview(imageView)
        
    }
    
    func moveCarToLeft() {
        
    }
    
    @objc func handleLeftTap(_ sender: UITapGestureRecognizer) {
        UIImageView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.carImageView.layer.position = CGPoint(x: 0, y: UIScreen.main.bounds.height - self.carImageView.bounds.height)
        })
    }
    
    @objc func handleRightTap(_ sender: UITapGestureRecognizer) {
        UIImageView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.carImageView.layer.position = CGPoint(x: UIScreen.main.bounds.width - self.carImageView.bounds.width, y: UIScreen.main.bounds.height - self.carImageView.bounds.height)
        })
    }
    
    func moveCarToRight(){
        
    }
    
    func nukeAllAnimations() {
        roadViewOutlet.subviews.forEach({$0.layer.removeAllAnimations()})
        roadViewOutlet.layer.removeAllAnimations()
        roadViewOutlet.layoutIfNeeded()
    }
    
    
}
