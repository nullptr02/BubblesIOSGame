//
//  PlayViewController.swift
//  Bubbles
//
//  Created by Michael on 2022-05-03.
//

import Foundation
import UIKit

class PlayViewController: UIViewController {
    
    let userDefaults = UserDefaults()
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    var remainingTime = 60
    var score = 0
    var highcsore = 0
    var timer = Timer()
    var bubble = Bubbles()
    var maxBubbles = 0
    var bubbleArray = [Bubbles]()
    var prev = 9999
    var highscoreDictionary = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = String(score)
        
        countdownLabel.text = String((userDefaults.value(forKey: "gameTime") as! Int)) + "s"
        remainingTime = userDefaults.value(forKey: "gameTime") as! Int
        highcsore = userDefaults.value(forKey: "highScore") as! Int
        highscoreLabel.text = String(highcsore)
        highscoreDictionary = userDefaults.value(forKey: "leaderboard") as! [String: Int]
        
        // Start the timer and create a bubble for each interval
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.counting()
            self.removeBubble()
            self.generateBubble()
        }
    }
    
    func checkHighScore(name: String) {
        
        let playerName: String = userDefaults.value(forKey: "playerName") as! String
        
        if (userDefaults.value(forKey: playerName) == nil) {
            userDefaults.set(score, forKey: playerName)
            highscoreDictionary.updateValue(score, forKey: playerName)
            userDefaults.setValue(highscoreDictionary, forKey: "leaderboard")
        } else {
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
