//
//  SettingsViewController.swift
//  RaceGame
//
//  Created by Roman Dod on 7/20/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    enum Direction {
        case left
        case right
    }

    var currentImageIndex = 0
    var durationAnimation = 0.3
    var delayAnimation = 0.1
    var carImagesArray = [UIImage]()
    var obstructionImagesArray = [UIImage]()
    var animationInProgress = false

    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var selectCarLabel: UILabel!
    @IBOutlet weak var selectObstructionLabel: UILabel!
    @IBOutlet weak var selectGameSpeedLabel: UILabel!
    @IBOutlet weak var nextCarButton: UIButton!
    @IBOutlet weak var selectCarImageView: UIImageView!
    @IBOutlet weak var selectObstructionsImageView: UIImageView!
    @IBOutlet weak var nextObstructionButton: UIButton!
    @IBOutlet weak var previousObstructionButton: UIButton!
    @IBOutlet weak var setSpeedSlider: UISlider!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        carImagesArray.append(Images.grey_car!)
        carImagesArray.append(Images.yellow_car!)
        carImagesArray.append(Images.mercedes!)
        carImagesArray.append(Images.police!)


        obstructionImagesArray.append(Images.cone1!)
        obstructionImagesArray.append(Images.cone2!)
        obstructionImagesArray.append(Images.tree!)


        selectCarImageView?.image = carImagesArray.first
        selectObstructionsImageView?.image = obstructionImagesArray.first
    }



    @IBAction func pressedSettingsButton(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextCarPressedButton(_ sender: UIButton) {

        guard !animationInProgress else {
            return
        }

        var nextIndex = currentImageIndex + 1
        if nextIndex > carImagesArray.count - 1 {
            nextIndex = 0
        }

        animateCarImage(imageIndex: nextIndex, direction: Direction.right)
    }
    @IBAction func previousCarPressedButton(_ sender: UIButton) {

        guard !animationInProgress else {
                return
            }

            var nextIndex = currentImageIndex - 1
            if nextIndex < 0 {
                nextIndex = carImagesArray.count - 1
            }

            animateCarImage(imageIndex: nextIndex, direction: Direction.left)
    }
    @IBAction func nextObstructionPressedButton(_ sender: UIButton) {

        guard !animationInProgress else {
            return
        }

        var nextIndex = currentImageIndex + 1
        if nextIndex > obstructionImagesArray.count - 1 {
            nextIndex = 0
        }

        animateObstructionImage(imageIndex: nextIndex, direction: Direction.right)
    }


    @IBAction func previousObstructionPressedButton(_ sender: UIButton) {
        guard !animationInProgress else {
            return
        }

        var nextIndex = currentImageIndex - 1
        if nextIndex < 0 {
            nextIndex = carImagesArray.count - 1
        }

        animateObstructionImage(imageIndex: nextIndex, direction: Direction.left)
    }
    
    
    @IBAction func setSpeedActionSlider(_ sender: UISlider) {
    }
    
    @IBAction func pressedSaveButton(_ sender: UIButton) {         
    }
    
    func saveImage(image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return nil}
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print("error saving file with error", error)
            return nil
        }
        
    }
    
    
    private func animateCarImage(imageIndex: Int, direction: Direction){
     animationInProgress = true
        let frame = selectCarImageView.bounds

     let imgView = UIImageView(frame: frame)
     imgView.contentMode = .scaleAspectFit
     imgView.backgroundColor = .white
     imgView.image = carImagesArray[imageIndex]

     let center = selectCarImageView?.center as! CGPoint
     imgView.center = center
     switch direction {
     case .left:
         imgView.center.x = (selectCarImageView?.center.x)! - (selectCarImageView?.bounds.width)!
     case .right:
         imgView.center.x = (selectCarImageView?.center.x)! + (selectCarImageView?.bounds.width)!
     }

     view.addSubview(imgView)
     UIView.animate(withDuration: durationAnimation, delay: delayAnimation, options: .curveEaseIn, animations: {

         imgView.center = center

     }) {(_) in
         self.animationInProgress = false

         switch direction {
         case .left:
             self.currentImageIndex -= 1

             if self.currentImageIndex > self.carImagesArray.count - 1{
                 self.currentImageIndex = 0
             }
         case .right:
             self.currentImageIndex += 1

             if self.currentImageIndex < 0 {
                 self.currentImageIndex = self.carImagesArray.count - 1
             }
         }
     }

    }
    
    private func animateObstructionImage(imageIndex: Int, direction: Direction){
     animationInProgress = true
        let frame = selectObstructionsImageView.bounds

     let imgView = UIImageView(frame: frame)
     imgView.contentMode = .scaleAspectFit
     imgView.backgroundColor = .white
     imgView.image = obstructionImagesArray[imageIndex]

     let center = selectObstructionsImageView?.center as! CGPoint
     imgView.center = center
     switch direction {
     case .left:
         imgView.center.x = (selectObstructionsImageView?.center.x)! - (selectObstructionsImageView?.bounds.width)!
     case .right:
         imgView.center.x = (selectObstructionsImageView?.center.x)! + (selectObstructionsImageView?.bounds.width)!
     }

     view.addSubview(imgView)
     UIView.animate(withDuration: durationAnimation, delay: delayAnimation, options: .curveEaseIn, animations: {

         imgView.center = center

     }) {(_) in
         self.animationInProgress = false

         switch direction {
         case .left:
             self.currentImageIndex -= 1

             if self.currentImageIndex > self.obstructionImagesArray.count - 1{
                 self.currentImageIndex = 0
             }
         case .right:
             self.currentImageIndex += 1

             if self.currentImageIndex < 0 {
                 self.currentImageIndex = self.obstructionImagesArray.count - 1
             }
         }
     }

    }

}



