//
//  ViewController.swift
//  project5
//
//  Created by user165519 on 5/29/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        // Do any additional setup after loading the view.
        self.title = "test"
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        if let startWords = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
        allWords = ["silkworm"]
        }
        
        let newGame=UIBarButtonItem( barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(setNewGame))
        navigationItem.leftBarButtonItems = [newGame]
        startGame()
    }
    
    @objc func setNewGame(){
        startGame()
        tableView.reloadData()
    }
   
    func startGame(){
        title = allWords.randomElement()
        print(title)
        usedWords.removeAll(keepingCapacity: true)
        //tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
    }
    
    //override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //return "Section \(section)"
    //}
    
    @objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
        guard let answer = ac?.textFields?[0].text else { return }
        self?.submit(answer)
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()
        let errorTitle: String
    let errorMessage: String
        
    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer) {
            if isReal(word: lowerAnswer) {
                if isLong(word: lowerAnswer) {
                    
                
                    usedWords.insert(answer.lowercased(), at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
                return
                }else{
                errorTitle = "Word is not long enough"
                    errorMessage = "make up something longer!"
                }
                
            } else {
                errorTitle = "Word not recognised"
                errorMessage = "You can't just make them up, you know!"
            }
        }else {
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        }
    }else {
        guard let title = title?.lowercased() else { return }
        errorTitle = "Word not possible"
        errorMessage = "You can't spell that word from \(title)"
        }
        
        showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage)
    }
    
    func showErrorMessage(errorTitle: String,errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "OK", style: .default))
               present(ac, animated: true)
    }
    
    
    func isPossible(word: String) -> Bool {
        if(word.lowercased() == title?.lowercased()) {return false}
          guard var tempWord = title?.lowercased() else { return false }

    for letter in word {
        if let position = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: position)
        } else {
            return false
        }
    }

    return true
        
    }

func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
    }

func isReal(word: String) -> Bool {
     let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
    }
    
    func isLong(word: String) -> Bool {
        return !(word.count <= 3)
    }
    
}

