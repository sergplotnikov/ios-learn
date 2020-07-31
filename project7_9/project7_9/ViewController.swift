//
//  ViewController.swift
//  project7_9
//
//  Created by user165519 on 7/3/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    var currentWordCnt = 0
    var currentWord: String = ""
    var words = [String]()
    var explains = [String]()
    var scoreLabel: UILabel!
    var explainLabel: UILabel!
    var currentAnswer: UITextField!
    var displayLabel: UILabel!
    var score = 0 {
        didSet { scoreLabel.text = "Score: \(score)"}
    }
    
    override func loadView() {
     view = UIView()
     view.backgroundColor = .white
     scoreLabel = UILabel()
     scoreLabel.translatesAutoresizingMaskIntoConstraints = false
     scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
     view.addSubview(scoreLabel)
    
        displayLabel = UILabel()
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.textAlignment = .center
        displayLabel.text = "Key Word"
        view.addSubview(displayLabel)
        
        explainLabel = UILabel()
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        explainLabel.font = UIFont.systemFont(ofSize: 14)
        explainLabel.text = "EXPLAIN EXPLAIN EXPLAIN EXPLAIN EXPLAIN EXPLAIN EXPLAIN EXPLAIN EXPLAIN"
        explainLabel.numberOfLines = 0
        explainLabel.textAlignment = .center
        view.addSubview(explainLabel)

        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap here to enter letters"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 20)
        currentAnswer.isUserInteractionEnabled = true
        currentAnswer.delegate = self
        view.addSubview(currentAnswer)

                let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
                submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
                

        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
                clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
                
                      //  clear.layer.borderWidth = 1
                //clear.layer.borderColor = UIColor.lightGray.cgColor
                   //     submit.layer.borderWidth = 1
               // submit.layer.borderColor = UIColor.lightGray.cgColor
                
    
       NSLayoutConstraint.activate([
        
        displayLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        displayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        //displayLabel.heightAnchor.constraint(equalToConstant: 44),
        
        
        scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            // pin the top of the clues label to the bottom of the score label
        explainLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

        // pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
        explainLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),

        // make the clues label 60% of the width of our layout margins, minus 100
        explainLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.9, constant: -10),
        
        currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
         currentAnswer.topAnchor.constraint(equalTo: explainLabel.bottomAnchor, constant: 20),

        submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
        submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
        submit.heightAnchor.constraint(equalToConstant: 44),

        clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
        clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
        clear.heightAnchor.constraint(equalToConstant: 44),
        

       ]);
    
    }
    
    @objc func submitTapped(){
        
        if  let currentLetter = currentAnswer.text?.lowercased() {
            if currentLetter.isEmpty { return }
            if currentWord.contains(currentLetter){
                var word = displayLabel.text! //Array(Character)(arrayLiteral: displayLabel.text)
                if !word.contains(currentLetter)
                {
                    var cword = word.map{ String($0) }
                    for (i,letter) in currentWord.enumerated() {
                    if (currentLetter == String(letter)){
                        cword[i] = String(letter)
                        score += 1
                        }
                     }
                
                word = cword.joined()
                    displayLabel.text = word
                    if !word.contains("?"){
                        let ac = UIAlertController(title: word, message: "You got it!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Next word", style: .default, handler: nil))
                        present(ac, animated: true)
                        lunchGame()
                        
                    }
                clearTapped()
                }
            }
            else {
               score -= 1
                if score >= -7 {
                let ac = UIAlertController(title: "Error", message: "You struck out!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac, animated: true)
                    clearTapped()
                }
                else {currentWordCnt=0
                    score = 0
                    let ac = UIAlertController(title: "Game's over", message: "You failed!", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(ac, animated: true)
                    clearTapped()
                    lunchGame()
                }
                 clearTapped()
            }
            
            
            
            
        }
        
    }
    
    @objc func clearTapped(){
        currentAnswer.text=""
    }
    
    @objc func lunchGame(){
        if currentWordCnt < words.count {
            explainLabel.text = explains[currentWordCnt]
            let word=words[currentWordCnt]
            currentWord = word
            var hint=""
            for _ in 0...word.count-1 {
                hint += "?"
            }
            displayLabel.text = hint
            currentWordCnt += 1
        } else {
            let ac = UIAlertController(title: "Info", message: "No word is left. Reset to the begining.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
            currentWordCnt = 0;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performSelector(inBackground: #selector(loadWords), with: nil)
    }

    @objc func loadWords(){
        if let fileURL = Bundle.main.url(forResource: "file7_9", withExtension: "txt"){
            if let contents = try? String(contentsOf: fileURL){
                var lines = contents.components(separatedBy: "\n")
                lines.shuffle()
                for line in lines{
                    if( line.contains("=")){
                    let parts = line.components(separatedBy: "=")
                    let word = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    let clue = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    words.append(word)
                    explains.append(clue)
                }
             }
            }
        }
        
        performSelector(onMainThread: #selector(lunchGame), with: nil,waitUntilDone: false)
    }

    // Use this if you have a UITextField
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    // get the current text, or use an empty string if that failed
    let currentText = textField.text ?? ""

    // attempt to read the range they are trying to change, or exit if we can't
     guard let stringRange = Range(range, in: currentText) else { return false }

    // add their new text to the existing text
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

    return updatedText.count <= 1
}
    
    
}

/*
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 30 // replace 30 for your max length value
    }
}*/
