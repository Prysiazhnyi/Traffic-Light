//
//  ViewController.swift
//  Traffic light
//
//  Created by Serhii Prysiazhnyi on 06.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yelowView: UIView!
    @IBOutlet weak var greenView: UIView!
    
    var timer: Timer?
    var remainingSeconds = 10
    var selectLight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Массив для удобства обработки
        let trafficLightViews: [UIView] = [redView, yelowView, greenView]
        
        for view in trafficLightViews {
            trafficLoghtView(view)
        }
        
        selectTrafficLight()
        
    }
    
    @IBAction func actionButtom(_ sender: Any) {
        selectTrafficLight()
    }
    
    func trafficLoghtView(_ view: UIView) {
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .clear
    }
    
    
    func startTimer() {
        timer?.invalidate() // Останавливаем предыдущий таймер, если он есть
        updateTimeLabel() // Обновляем метку сразу
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1 // Уменьшаем время
            updateTimeLabel() // Обновляем текст метки
        } else {
            timer?.invalidate() // Останавливаем таймер
            remainingSeconds = 10
            selectTrafficLight()
            //startTimer() // Снова запускаем таймер
        }
    }
    
    func updateTimeLabel() {
        timeLabel.text = String(format: "%02d", remainingSeconds)
        //timeLabel.textColor = .red
    }
    
    func selectTrafficLight() {
        
        selectLight += 1
        
        // Сбрасываем все цвета
            redView.backgroundColor = .clear
            yelowView.backgroundColor = .clear
            greenView.backgroundColor = .clear
        
        if selectLight > 2 {
            selectLight = 0
        }
        
        // Включаем свет
        switch selectLight {
        case 0:
            redView.backgroundColor = .red
            timeLabel.textColor = .red
            remainingSeconds = 5
        case 1:
            yelowView.backgroundColor = .yellow
            timeLabel.textColor = .yellow
            remainingSeconds = 3
        case 2:
            greenView.backgroundColor = .green
            timeLabel.textColor = .green
            remainingSeconds = 8
        default:
            break
        }
        startTimer()
        print("Current Light: \(selectLight), time = \(remainingSeconds)")
       
    }
    
}

