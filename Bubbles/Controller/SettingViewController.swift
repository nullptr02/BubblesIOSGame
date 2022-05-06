//
//  SettingViewController.swift
//  Bubbles
//
//  Created by Michael on 2022-05-03.
//

import Foundation
import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    let userDefaults = UserDefaults()
    
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var noBubblesLabel: UILabel!
    @IBOutlet weak var timerSlider: UISlider!
    @IBOutlet weak var maxBubbleSlider: UISlider!
    
    @IBAction func closeSettingsButton(_ sender: Any) {
        self.removeAnimation()
    }
    
    @IBAction func maxTimeSlider(_ sender: UISlider) {
        
        var maxTime = Int(sender.value)
        userDefaults.setValue(maxTime, forKey: "gameTime")
        timeLabel.text = String(maxTime) + "s"
        
    }
    
    @IBAction func maxBubblesSlider(_ sender: UISlider) {
        var maxBubbles = Int(sender.value)
        userDefaults.setValue(maxBubbles, forKey: "noBubbles")
        noBubblesLabel.text = String(maxBubbles)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.showAnimation()
        playerName.delegate = self
        
        if let value = userDefaults.value(forKey: "playerName") as? String {
            playerName.text = value
        }
        
        if let value = userDefaults.value(forKey: "gameTime") as? Float {
            timerSlider.value = value
        }
        
        if let value = userDefaults.value(forKey: "gameTime") as? Int {
            timeLabel.text = String(value) + "s"
        }
        
        if let value = userDefaults.value(forKey: "noBubbles") as? Float {
            maxBubbleSlider.value = value
        }
        
        if let value = userDefaults.value(forKey: "noBubbles") as? Int {
            noBubblesLabel.text = String(value)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userDefaults.setValue(playerName.text, forKey: "playerName")
        playerName.resignFirstResponder()
        return true
    }
    
    func showAnimation() {
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimation() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished) {
                self.view.removeFromSuperview()
            }
        });
    }
    
}
