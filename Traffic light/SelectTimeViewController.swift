//
//  SelectTimeViewController.swift
//  Traffic light
//
//  Created by Serhii Prysiazhnyi on 06.01.2025.
//

import UIKit

class SelectTimeViewController: UIViewController {
    
    var redLightData: [Int] = []
    var yellowLightData: [Int] = []
    var greenLightData: [Int] = []
    
    var configureForLightType: String = ""
    
    var selectedData: [Int] = [] // Массив для выбранного времени
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем selectedData в зависимости от выбранного типа света
        switch configureForLightType {
        case "Red":
            selectedData = redLightData
        case "Yellow":
            selectedData = yellowLightData
        case "Green":
            selectedData = greenLightData
        default:
            selectedData = redLightData
        }
        tableView.reloadData()
    }
}

extension SelectTimeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = String(selectedData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Обновляем настройки в зависимости от выбранного времени
        if selectedData == redLightData {
            Settings.shared.currentSettings.timeForRedLight = selectedData[indexPath.row]
        } else if selectedData == yellowLightData {
            Settings.shared.currentSettings.timeForYellowLight = selectedData[indexPath.row]
        } else {
            Settings.shared.currentSettings.timeForGreenLight = selectedData[indexPath.row]
        }
        
        navigationController?.popViewController(animated: true)
    }
}
