//
//  Bubbles.swift
//  Bubbles
//
//  Created by Michael on 2022-04-26.
//

import Foundation
import UIKit

class Bubbles: UIButton {
    
    var val: Int = 0
    
    //Get the screen dimensions
    let screenSize: CGRect = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: CGFloat(Int.random(in: 60...Int(screenSize.width - 90))), y: CGFloat(Int.random(in: 150...Int(screenSize.height - 120))), width: 80, height: 80)
        
        
        // probablilty of the bubbles appearing
        
            let probability = Int(arc4random_uniform(100))
            
            switch probability {
                
            case 0...39:
                self.setImage(UIImage(named: "green"), for: .normal)
                self.val = 1
                
            case 40...69:
                self.setImage(UIImage(named: "black"), for: .normal)
                self.val = 2
                
            case 70...84:
                self.setImage(UIImage(named: "pink"), for: .normal)
                self.val = 4
                
            case 85...94:
                self.setImage(UIImage(named: "blue"), for: .normal)
                self.val = 8
                
            case 95...99:
                self.setImage(UIImage(named: "red"), for: .normal)
                self.val = 16
                
            default:
                return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation() {
        let anime = CASpringAnimation(keyPath: "transform.scale")
        anime.duration = 0.4
        anime.fromValue = 0.6
        anime.toValue = 1
        anime.repeatCount = 1
        anime.initialVelocity = 0.6
        anime.damping = 1
        layer.add(anime, forKey: nil)
    
    }
    
}

