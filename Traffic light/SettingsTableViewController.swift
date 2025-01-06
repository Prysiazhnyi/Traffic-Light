//
//  SettingsTableViewController.swift
//  Traffic light
//
//  Created by Serhii Prysiazhnyi on 06.01.2025.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var timeRedLight: UILabel!
    @IBOutlet weak var timeYellowLight: UILabel!
    @IBOutlet weak var timeGreenLight: UILabel!
    
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 30, 40, 50, 60]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings Time Light"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    func loadSettings() {
        // Проверяем на nil каждый лейбл и обновляем их текст
        if let timeRedLabel = timeRedLight {
            timeRedLabel.text = "\(Settings.shared.currentSettings.timeForRedLight)s"
        } else {
            print("timeRedLight is nil")
        }
        
        if let timeYellowLabel = timeYellowLight {
            timeYellowLabel.text = "\(Settings.shared.currentSettings.timeForYellowLight)s" // Здесь можно использовать другие значения, если необходимо
        } else {
            print("timeYellowLight is nil")
        }
        
        if let timeGreenLabel = timeGreenLight {
            timeGreenLabel.text = "\(Settings.shared.currentSettings.timeForGreenLight)s" // Здесь также можно использовать другие значения
        } else {
            print("timeGreenLight is nil")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeRedVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.redLightData = data
                vc.configureForLightType = "Red"
            }
        case "selectTimeYellowVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.yellowLightData = data
                vc.configureForLightType = "Yellow"
            }
        case "selectTimeGreenVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.greenLightData = data
                vc.configureForLightType = "Green"
            }
        default :
            break
        }
    }
}
