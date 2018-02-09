//
//  ViewController.swift
//  MiniProject1
//
//  Created by Aditya Yadav on 2/8/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bgLabel: UIView!
    var startButton: UIButton!
    var projectLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeBackground()
        initializeFeatures()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeBackground() {
        bgLabel = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        //rgb(238, 82, 83)
        let colorTop =  UIColor(red: 238/255, green: 82/255, blue: 83/255, alpha: 1.0).cgColor
        
        //rgb(255, 159, 67)
        let colorBottom = UIColor(red: 255/255, green: 159/255, blue: 67/255, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.5, 1.0]
        gradientLayer.frame = self.view.bounds
        bgLabel.layer.insertSublayer(gradientLayer, at: 0)
        
        view.insertSubview(bgLabel, at: 0)

    }
    
    func initializeFeatures() {
        
        //label config
        projectLabel = UILabel(frame: CGRect(x: 20, y: view.frame.height / 4, width: view.frame.width - 40, height: 50))
        projectLabel.textColor = .white
        projectLabel.text = "Match the Members!"
        projectLabel.textAlignment = .center
        projectLabel.font = UIFont(name: "Georgia", size: 30)
        
        view.addSubview(projectLabel)
        
        
        //button
        startButton = UIButton(type: .custom)
        startButton.frame = CGRect(x: 50, y: view.frame.height / 4 + 100, width: view.frame.width - 100, height: 50)
        startButton.backgroundColor = .clear
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 5
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.red, for: .highlighted)
        startButton.titleLabel?.font = UIFont(name: "Georgia", size: 20)
        startButton.titleLabel?.textAlignment = .center
        startButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        
        view.addSubview(startButton)
        
    }
    
    @objc func buttonReleased() {
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.backgroundColor = .clear
        
        //animation attempt :)
        UIView.animate(withDuration: 0.3) {
            self.startButton.frame.origin.y = self.view.frame.height - 75
            self.startButton.alpha = 0.0
            self.projectLabel.alpha = 0.0
            //rgb(255, 159, 67)
            let colorBottom = UIColor(red: 255/255, green: 159/255, blue: 67/255, alpha: 1.0)
            self.startButton.backgroundColor = colorBottom;
        }
        
        //wait then segue
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (Timer) in
            //seems to work
            self.performSegue(withIdentifier: "first", sender: self)
        }
        
    }


}

