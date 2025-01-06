//
//  ViewController.swift
//  Traffic light
//
//  Created by Serhii Prysiazhnyi on 06.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabelRed: UILabel!
    @IBOutlet weak var timeLabelYellow: UILabel!
    @IBOutlet weak var timeLabelGreen: UILabel!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yelowView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var timer: Timer?
    var remainingSeconds = 0
    var secondsRed = 6
    var secondsYellow = 3
    var secondsGreen = 10
    var selectLight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Массив для удобства обработки
        let trafficLightViews: [UIView] = [redView, yelowView, greenView]
        
        for view in trafficLightViews {
            trafficLoghtView(view)
        }
        
        selectTrafficLight()
        
        nextButton.setTitle("Next", for: .normal)
    }
    
    @IBAction func actionButtom(_ sender: Any) {
        selectLight += 1
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
            selectLight += 1
        }
    }
    
    func updateTimeLabel() {
        
        timeLabelRed.text?.removeAll()
        timeLabelYellow.text?.removeAll()
        timeLabelGreen.text?.removeAll()
        
        switch selectLight {
        case 0:
            timeLabelRed.text = String(format: "%02d", remainingSeconds)
        case 1:
            timeLabelYellow.text = String(format: "%02d", remainingSeconds)
        case 2:
            timeLabelGreen.text = String(format: "%02d", remainingSeconds)
        default:
            break
        }
    }
    
    func selectTrafficLight() {
        
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
            nextButton.setTitleColor(.yellow, for: .normal)
            remainingSeconds = secondsRed
        case 1:
            yelowView.backgroundColor = .yellow
            nextButton.setTitleColor(.green, for: .normal)
            remainingSeconds = secondsYellow
        case 2:
            greenView.backgroundColor = .green
            nextButton.setTitleColor(.red, for: .normal)
            remainingSeconds = secondsGreen
        default:
            break
        }
        startTimer()
        print("Current Light: \(selectLight), time = \(remainingSeconds)")
       
    }
}

