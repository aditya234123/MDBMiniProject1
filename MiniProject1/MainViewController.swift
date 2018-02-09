//
//  MainViewController.swift
//  MiniProject1
//
//  Created by Aditya Yadav on 2/8/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var bgLabel: UIView!
    var stopButton: UIButton!
    var imageView: UIImageView!
    var answer0: UIButton!
    var answer1: UIButton!
    var answer2: UIButton!
    var answer3: UIButton!
    
    var correctAnswer = 0
    var score = 0
    
    //stats
    
    
    var seconds = 0
    
    var timer = Timer()
    var paused = false
    
    var members = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffrey Zhang"];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeBackground()
        setUpStatIcon()
        setButton()
        setQuestion()
        getRandom()
        let colorTop =  UIColor(red: 238/255, green: 82/255, blue: 83/255, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = colorTop
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeUp), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (paused) {
            pauseOrResume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpStatIcon() {
        
        let tmpBtn = UIButton(type: .custom)
        tmpBtn.setImage(UIImage(named: "graph"), for: .normal)
        tmpBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        tmpBtn.addTarget(self, action: #selector(segueToStats), for: .touchUpInside)
        let item = UIBarButtonItem(customView: tmpBtn)
        self.navigationItem.setRightBarButton(item, animated: true)
    }
    
    @objc func segueToStats() {
        performSegue(withIdentifier: "second", sender: self)
        pauseOrResume()
    }
    
    func pauseOrResume() {
        if paused {
            paused = false
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeUp), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            paused = true
        }
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
        
        //score label
        scoreLabel = UILabel(frame: CGRect(x: 10, y: (self.navigationController?.navigationBar.frame.height)! + 30, width: view.frame.width - 20, height: 20))
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont(name: "Georgia", size: scoreLabel.font.pointSize)
        scoreLabel.textColor = .white
        
        view.addSubview(scoreLabel)
    }
    
    func setButton() {
        let height = view.frame.height / 10
        stopButton = UIButton(frame: CGRect(x: 50, y: view.frame.height - height - 15, width: view.frame.width - 100, height: height))
        stopButton.backgroundColor = .clear
        stopButton.layer.cornerRadius = 5
        stopButton.layer.borderWidth = 5
        stopButton.layer.borderColor = UIColor.white.cgColor
        stopButton.setTitle("Stop", for: .normal)
        stopButton.titleLabel?.font = UIFont(name: "Georgia", size: 20)
        stopButton.titleLabel?.textAlignment = .center
        
        view.addSubview(stopButton)
    }
    
    func setQuestion() {
        let height = view.frame.height / 10
        let offset = (view.frame.width - (height * 4)) / 2
        
        //imageview
        imageView = UIImageView(frame: CGRect(x: offset, y: (self.navigationController?.navigationBar.frame.height)! + height, width: height * 4, height: height * 4))
        imageView.backgroundColor = .red
        view.addSubview(imageView)
        
        //rgb(69, 170, 242)
        let buttonColor = UIColor(red: 69/255, green: 170/255, blue: 242/255, alpha: 1.0)
        let upperbuttonOffset = view.frame.height - height - 15 - 2.5 * height
        
        //answer choices + a bunch of math that I hope is somewhat dynamic. Took a while :(
        answer0 = UIButton(frame: CGRect(x: 10, y: upperbuttonOffset, width: view.frame.width / 2 - 20, height: height))
        answer0.backgroundColor = buttonColor
        answer0.tag = 0
        answer1 = UIButton(frame: CGRect(x: 10 + view.frame.width / 2 - 20 + 20, y: upperbuttonOffset, width: view.frame.width / 2 - 20, height: height))
        answer1.backgroundColor = buttonColor
        answer1.tag = 1
        answer2 = UIButton(frame: CGRect(x: 10, y: upperbuttonOffset + height + 10, width: view.frame.width / 2 - 20, height: height))
        answer2.backgroundColor = buttonColor
        answer2.tag = 2
        answer3 = UIButton(frame: CGRect(x: 10 + view.frame.width / 2 - 20 + 20, y: upperbuttonOffset + height + 10, width: view.frame.width / 2 - 20, height: height))
        answer3.backgroundColor = buttonColor
        answer3.tag = 3
        view.addSubview(answer0)
        view.addSubview(answer1)
        view.addSubview(answer2)
        view.addSubview(answer3)
        
    }
    
    func getRandom() {
        
        //need four random numbers
        var rand1 = Int(arc4random_uniform(54))
        var rand2 = Int(arc4random_uniform(54))
        var rand3 = Int(arc4random_uniform(54))
        var rand4 = Int(arc4random_uniform(54))
        
        while (rand1 == rand2 || rand1 == rand3 || rand1 == rand4 || rand2 == rand3 || rand2 == rand4 ||
            rand3 == rand4) {
                rand1 = Int(arc4random_uniform(54))
                rand2 = Int(arc4random_uniform(54))
                rand3 = Int(arc4random_uniform(54))
                rand4 = Int(arc4random_uniform(54))
        }
        
        //will decide which is correct answer
        let randAnswer = Int(arc4random_uniform(4))
        correctAnswer = randAnswer
        
        ///OK GO SET UP IMAGEVIEW AND 4 BUTTONS THEN COME BACK.
        //yay
        setUpAnswers(rand1: rand1, rand2: rand2, rand3: rand3, rand4: rand4)
        
        var correctImage = UIImage()
        var imageName = ""
        //get image of correct one
        switch(randAnswer) {
        case 0:
            imageName = members[rand1].lowercased()
            break
        case 1:
            imageName = members[rand2].lowercased()
            break
        case 2:
            imageName = members[rand3].lowercased()
            break
        case 3:
            imageName = members[rand4].lowercased()
            break
        default:
            break
        }
        let correctName = imageName.replacingOccurrences(of: " ", with: "")
        correctImage = UIImage(named: correctName)!
        imageView.image = correctImage
        
    }
    
    @objc func timeUp() {
        seconds += 1
        
        if (seconds > 4) {
        //disable all
        //set all to red for 1 second.
        //reset
        
        answer0.isUserInteractionEnabled = false
        answer1.isUserInteractionEnabled = false
        answer2.isUserInteractionEnabled = false
        answer3.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 1) {
            self.answer0.backgroundColor = .red
            self.answer1.backgroundColor = .red
            self.answer2.backgroundColor = .red
            self.answer3.backgroundColor = .red
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
            self.getRandom()
        }
        seconds = 0
            
        }
        
        
    }
    
    func setUpAnswers(rand1: Int, rand2: Int, rand3: Int, rand4: Int) {
        
        let fontSize = answer0.titleLabel?.font.pointSize
        answer0.setTitle(members[rand1], for: .normal)
        answer0.titleLabel?.font = UIFont(name: "Georgia", size: fontSize!)
        answer1.setTitle(members[rand2], for: .normal)
        answer1.titleLabel?.font = UIFont(name: "Georgia", size: fontSize!)
        answer2.setTitle(members[rand3], for: .normal)
        answer2.titleLabel?.font = UIFont(name: "Georgia", size: fontSize!)
        answer3.setTitle(members[rand4], for: .normal)
        answer3.titleLabel?.font = UIFont(name: "Georgia", size: fontSize!)
        
        answer0.titleLabel?.adjustsFontSizeToFitWidth = true;
        answer0.titleLabel?.numberOfLines = 0
        answer1.titleLabel?.adjustsFontSizeToFitWidth = true;
        answer1.titleLabel?.numberOfLines = 0
        answer2.titleLabel?.adjustsFontSizeToFitWidth = true;
        answer2.titleLabel?.numberOfLines = 0
        answer3.titleLabel?.adjustsFontSizeToFitWidth = true;
        answer3.titleLabel?.numberOfLines = 0
        
        answer0.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        answer1.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        answer2.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        answer3.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        answer0.addTarget(self, action: #selector(answerSelected), for: .touchUpInside)
        answer1.addTarget(self, action: #selector(answerSelected), for: .touchUpInside)
        answer2.addTarget(self, action: #selector(answerSelected), for: .touchUpInside)
        answer3.addTarget(self, action: #selector(answerSelected), for: .touchUpInside)
        
        //rgb(69, 170, 242)
        let buttonColor = UIColor(red: 69/255, green: 170/255, blue: 242/255, alpha: 1.0)
        answer0.backgroundColor = buttonColor
        answer1.backgroundColor = buttonColor
        answer2.backgroundColor = buttonColor
        answer3.backgroundColor = buttonColor
        
        answer0.isUserInteractionEnabled = true
        answer1.isUserInteractionEnabled = true
        answer2.isUserInteractionEnabled = true
        answer3.isUserInteractionEnabled = true
        
    }
    
    @objc func answerSelected(sender: UIButton) {
        
        //if wrong, animate 1 sec red
        //if right, animate 1 sec green
        
        //DISABLE ANSWER CHOICES DURING THIS TIME.
        
        //reset
        
        answer0.isUserInteractionEnabled = false
        answer1.isUserInteractionEnabled = false
        answer2.isUserInteractionEnabled = false
        answer3.isUserInteractionEnabled = false
        
        switch(sender.tag) {
        case correctAnswer:
            UIView.animate(withDuration: 1, animations: {
                sender.backgroundColor = .green
                self.score += 1
                self.scoreLabel.text = "Score: \(self.score)"
            })
            break
        default:
            UIView.animate(withDuration: 1, animations: {
                sender.backgroundColor = .red
            })
            break
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
            self.getRandom()
        }
        seconds = 0
        
    }

}
