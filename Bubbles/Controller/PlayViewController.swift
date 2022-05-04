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
            let playerScore: Int = userDefaults.value(forKey: playerName) as! Int
            if (playerScore < score) {
                userDefaults.set(score, forKey: playerName)
                highscoreDictionary.updateValue(score, forKey: playerName)
                userDefaults.setValue(highscoreDictionary, forKey: "leaderboard")
            }
        }
    }
    
    @objc func counting() {
        remainingTime -= 1
        countdownLabel.text = String(remainingTime) + "s"
        
        if remainingTime == 0 {
            timer.invalidate()
            
            // save score and check for the highest score
            let playerName: String = userDefaults.value(forKey: "playerName") as! String
            checkHighScore(name: playerName)
            
            //Display highscore
            
            let controller = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(controller, animated: true)
            controller.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    
    // check if bubbles collide
    func isOverlapped(newBubble: Bubbles) -> Bool {
        for eachBubble in bubbleArray {
            if newBubble.frame.intersects(eachBubble.frame) {
                return true
            }
        }
        return false
        
    }
    
    @objc func generateBubble() {
        
        let noBubbles = userDefaults.value(forKey: "noBubbles") as! Int
        let randomInt = Int.random(in: 0...noBubbles)
        var i = 0
        
        while (i < randomInt && maxBubbles < noBubbles) {
            bubble = Bubbles()
            
            // No overlapping
            if(!isOverlapped(newBubble: bubble)) {
                bubble.animation()
                self.view.addSubview(bubble)
                bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
                bubbleArray += [bubble]
                maxBubbles += 1
                i += 1
            }
        }
    }
    
    @objc func removeBubble() {
        let randomInt = Int.random(in: 0...bubbleArray.count)
        var i = 0
        
        
        while (i < randomInt) {
            let random = bubbleArray.randomElement()
            
            maxBubbles -= 1
            
            random!.removeFromSuperview()
            
            if let index = bubbleArray.firstIndex(of: random!) {
                bubbleArray.remove(at: index)
            }
            i += 1
        }
    }
    
    @IBAction func bubblePressed(_ sender: Bubbles) {
        
        if (sender.val == prev) {
            let a = Double(sender.val)
            score += Int(a.rounded())
            prev = sender.val
        } else {
            score += sender.val
            prev = sender.val
        }
        
        maxBubbles -= 1
        
        if let index = bubbleArray.firstIndex(of: sender.self) {
            bubbleArray.remove(at: index)
        }
        
        scoreLabel.text = String(score)
        
        
        if score > highcsore {
            highscoreLabel.text = scoreLabel.text
            userDefaults.setValue(score, forKey: "highScore")
        }
        
        sender.removeFromSuperview()
    }
 
    
}
