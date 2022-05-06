//
//  HighScoreViewController.swift
//  Bubbles
//
//  Created by Michael on 2022-05-03.
//

import Foundation
import UIKit

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    let userDefaults = UserDefaults()
    var nameScore = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userDefaults.value(forKey: "playerName") == nil {
            userDefaults.setValue("ANONYMOUS", forKey: "playerName")
        }
        if userDefaults.value(forKey: "leaderboard") != nil {
            nameScore = userDefaults.value(forKey: "leaderboard") as! [String: Int]
        }
        
        
    }
    
    @IBAction func returnMainPage(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension HighScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameScore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        
        let sortOne = nameScore.sorted {
            (first, second) -> Bool in
            return first.value > second.value
        }
        
        cell.textLabel?.text = "\(sortOne[indexPath.row].key)"
        cell.detailTextLabel?.text = "\(sortOne[indexPath.row].value)"
        
        return cell
    }
}
