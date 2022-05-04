//
//  ViewController.swift
//  Bubbles
//
//  Created by Michael on 2022-04-26.
//

import UIKit

class ViewController: UIViewController {
    
    let userDefault = UserDefaults()
    @IBOutlet var playBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        
        // Check to see if the player has changed any settings
        if userDefault.value(forKey: "gameTime") == nil {
            userDefault.setValue(60, forKey: "gameTime")
        }
        if userDefault.value(forKey: "playerName") == nil {
            userDefault.setValue("No Name", forKey: "playerName")
        }
        if userDefault.value(forKey: "highScore") == nil {
            userDefault.setValue(15, forKey: "highScore")
        }
        if userDefault.value(forKey: "leaderBoard") == nil {
            userDefault.setValue(["NO NAME": 0], forKey: "leaderBoard")
        }
        if userDefault.value(forKey: "noBubbles") == nil {
            userDefault.setValue(15, forKey: "noBubbles")
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as?
            PlayViewController {
            self.navigationController?.pushViewController(viewcontroller, animated: false)
        }
    }
    
    @IBAction func showSettings(_ sender: UIButton) {
        
        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
        
    }


}

