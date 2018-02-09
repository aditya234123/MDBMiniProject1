//
//  StatsViewController.swift
//  MiniProject1
//
//  Created by Aditya Yadav on 2/8/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var lastThree = [Bool]()
    var currentStreak = 0
    var bgLabel: UIView!
    
    var lastThreeLabel: UILabel!
    var longestLabel: UILabel!
    var recentLabel: UILabel!
    
    var oneLabel: UIImageView!
    var twoLabel: UIImageView!
    var threeLabel: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeBackground()
        addStats()
        self.navigationItem.title = "Stats"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addStats() {
        
        //longest streak
        longestLabel = UILabel(frame: CGRect(x: 10, y: (self.navigationController?.navigationBar.frame.height)! + 30, width: view.frame.width - 20, height: 40))
        longestLabel.text = "Longest Streak of Correct Answers: \(currentStreak)"
        longestLabel.textColor = .white
        longestLabel.font = UIFont(name: "Georgia", size: 17)
        longestLabel.textAlignment = .center
        
        view.addSubview(longestLabel)
        
        if lastThree.count != 0 {
            setUpLastThree()
        }
        
    }
    
    
    func setUpLastThree() {
        //last three
        lastThreeLabel = UILabel(frame: CGRect(x: 10, y: (self.navigationController?.navigationBar.frame.height)! + 80, width: view.frame.width - 20, height: 40))
        lastThreeLabel.text = "Results of last three: "
        lastThreeLabel.textColor = .white
        lastThreeLabel.font = UIFont(name: "Georgia", size: 18)
        lastThreeLabel.textAlignment = .center
        
        view.addSubview(lastThreeLabel)
        
        recentLabel = UILabel(frame: CGRect(x: 30 + view.frame.width / 3 - 10 + view.frame.width / 3 - 10, y: (self.navigationController?.navigationBar.frame.height)! + 220, width: view.frame.width / 3 - 40, height: view.frame.width / 3 - 40))
        recentLabel.text = "Most Recent"
        recentLabel.textColor = .white
        recentLabel.font = UIFont(name: "Georgia", size: 11)
        recentLabel.textAlignment = .center
        
        view.addSubview(recentLabel)
        
        oneLabel = UIImageView(frame: CGRect(x: 30, y: (self.navigationController?.navigationBar.frame.height)! + 150, width: view.frame.width / 3 - 40, height: view.frame.width / 3 - 40))
        twoLabel = UIImageView(frame: CGRect(x: 30 + view.frame.width / 3 - 10, y: (self.navigationController?.navigationBar.frame.height)! + 150, width: view.frame.width / 3 - 40, height: view.frame.width / 3 - 40))
        threeLabel = UIImageView(frame: CGRect(x: 30 + view.frame.width / 3 - 10 + view.frame.width / 3 - 10, y: (self.navigationController?.navigationBar.frame.height)! + 150, width: view.frame.width / 3 - 40, height: view.frame.width / 3 - 40))
        
        //determine if check or x
        
        let last = lastThree.count - 1
        let second = lastThree.count - 2
        let third = lastThree.count - 3
    
        if last >= 0  {
            if lastThree[last] {
                threeLabel.image = UIImage(named: "success")
            } else {
                threeLabel.image = UIImage(named: "cancel")
            }
        }
        if second >= 0  {
            if lastThree[second] {
                twoLabel.image = UIImage(named: "success")
            } else {
                twoLabel.image = UIImage(named: "cancel")
            }
        }
        if third >= 0  {
            if lastThree[third] {
                oneLabel.image = UIImage(named: "success")
            } else {
                oneLabel.image = UIImage(named: "cancel")
            }
        }
        
        view.addSubview(oneLabel)
        view.addSubview(twoLabel)
        view.addSubview(threeLabel)
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
    
}
