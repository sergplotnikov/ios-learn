//
//  ViewController.swift
//  project2
//
//  Created by user165519 on 4/8/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btton1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        btton1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        btton1.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor //UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction! = nil){
        if totalQuestions > 3 {
            let ac = UIAlertController(title: "Game over", message: "Your final score is \(score) out of \(totalQuestions).",preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Finish", style:  .default, handler: resetQuestion))
            present(ac, animated: true)
            
        }

        countries.shuffle()
        btton1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()). Your score is \(score) out of \(totalQuestions)."
    }
    func resetQuestion(action: UIAlertAction! = nil){
             score = 0
         correctAnswer = 0
         totalQuestions = 0
        askQuestion()
        
    }

    @IBAction func buttonTaped(_ sender: UIButton) {
                totalQuestions += 1
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        }
        else {
            title = "Wrong. That's the flag of \(countries[sender.tag])"
            score -= 0
            
        }
                if totalQuestions >= 3 {
                    let ac = UIAlertController(title: "\(title). \nGame over", message: "Your final score is \(score) out of \(totalQuestions).",preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Finish", style:  .default, handler: resetQuestion))
            present(ac, animated: true)
                }else {
        let ac = UIAlertController(title: title, message: "Your score is \(score)",preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style:  .default, handler: askQuestion))
        present(ac, animated: true)
        }
    }
}

