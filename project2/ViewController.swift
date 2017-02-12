//
//  ViewController.swift
//  project2x
//
//  Created by Otto Wichmann on 11/19/16.
//  Copyright © 2016 ottodevelops. All rights reserved.
//

import UIKit
import GameplayKit
class ViewController: UIViewController {
    var timer =  Timer()
    var countries = [String]()
    var count = 10 {
        didSet{
            self.countDownLabel.text = "Time: \(self.count)"
        }
    }

    var score = 0 {
        didSet{
            self.scoreLabel.text = "Score: \(self.score)"
        }
    }
    var correctAnswer = 0
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 21))
        label.center = CGPoint(x: 50, y: 100)
        label.textAlignment = .center
        label.text = "Score: \(self.score)"
        label.textColor = UIColor.black
        label.font = UIFont(name: "System", size: 25)
        return label
    }()
    
    lazy var countDownLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 21))
        label.center = CGPoint(x: 50, y: 125)
        label.textAlignment = .center
        label.text = "Time: \(self.count)"
        label.textColor = UIColor.black
        label.font = UIFont(name: "System", size: 25)
        return label
    }()
    lazy var  buttonStart: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 40, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonOne: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 40, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.borderWidth = 1
        button.tag = 0
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        return button
    }()
    
    
    lazy var buttonTwo: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.borderWidth = 1
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)

        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    lazy var buttonThree: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 180, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.borderWidth = 1
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        loadCountries()
        askQuestion(action: nil)
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(buttonThree)
        view.addSubview(scoreLabel)
        view.addSubview(countDownLabel)
        view.addSubview(buttonStart)
        setUpButtonOne()
        setUpButtonTwo()
        setUpButtonThree()
        setUpButtonStart()
        
        toggleFlagButtons(enable: false)

    }
    func toggleFlagButtons(enable: Bool) {
        if !enable{
            buttonOne.isEnabled = false
            buttonTwo.isEnabled = false
            buttonThree.isEnabled = false
        }else{
            buttonOne.isEnabled = true
            buttonTwo.isEnabled = true
            buttonThree.isEnabled = true
        }
    }
    func startGame() {
        toggleFlagButtons(enable: true)
        startTimer()
        askQuestion(action: nil)
       
    }
    func startTimer(){
        buttonStart.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countdown), userInfo: nil, repeats: true)
    }
    func countdown(){
        
        if(count == 0) {
            timer.invalidate()
            toggleFlagButtons(enable: false)

        } else {
            count = count - 1
        }
        print("x")
    }
    func buttonTouched(_ sender: UIButton)  {
        print(sender.tag)
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        if count <= 0 {
            let ac = UIAlertController(title: title, message: "Your score is \(score). Game Over", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: setUpGameAgain))
            present(ac, animated: true)
            print(count)
        } else {
            askQuestion(action: nil)
        }
    }
    func setUpGameAgain(action: UIAlertAction!) {
        score = 0
        count = 10
        buttonStart.isEnabled = true
    }
    func askQuestion(action: UIAlertAction!){
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        buttonOne.setBackgroundImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setBackgroundImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setBackgroundImage(UIImage(named:countries[2]), for: .normal)
        
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        title = countries[correctAnswer].uppercased()
    }
    func loadCountries(){
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    func setUpButtonStart(){
        buttonStart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStart.topAnchor.constraint(equalTo: buttonThree.bottomAnchor, constant: 50).isActive = true
        buttonStart.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonStart.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setUpButtonOne(){
        // need x, y, widht and height
        buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonOne.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        buttonOne.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonOne.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setUpButtonTwo(){
        // need x, y, widht and height
        buttonTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonTwo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonTwo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonTwo.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setUpButtonThree(){
        // need x, y, widht and height
        buttonThree.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonThree.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
        buttonThree.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonThree.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
