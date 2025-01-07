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
    
    var timer: Timer? {
        didSet {
            leftButtonBarButtomItem()
        }
    }
    var remainingSeconds = 0
    var secondsRed: Int = 0
    var secondsYellow: Int = 0
    var secondsGreen: Int = 0
    
    var titleLightMove: String {
        switch selectLight {
        case 0: return "Stop"
        case 1: return "Get ready"
        default: return "Move"
        }
    }
    
    var selectLight = 0 {
        didSet {
            // Обновляем заголовок экрана при изменении selectLight
            title = titleLightMove
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleLightMove
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(settingTimeLight))
        
        // Массив для удобства обработки
        let trafficLightViews: [UIView] = [redView, yelowView, greenView]
        
        for view in trafficLightViews {
            trafficLoghtView(view)
        }
        
        nextButton.setTitle("Next", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewIsAppearing(animated)
        loadTime()
        selectTrafficLight()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTrafficLight()
    }
    
    func leftButtonBarButtomItem() {
        if timer == nil {
                   navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(selectTrafficLight))
               } else {
                   navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopTrafficLight))
               }
    }
    
    func loadTime() {
        secondsRed = Settings.shared.currentSettings.timeForRedLight
        secondsYellow = Settings.shared.currentSettings.timeForYellowLight
        secondsGreen = Settings.shared.currentSettings.timeForGreenLight
    }
    
    @objc func stopTrafficLight() {
        timer?.invalidate()
        timer = nil
        selectLight = 0
        timeLabelRed.text?.removeAll()
        timeLabelYellow.text?.removeAll()
        timeLabelGreen.text?.removeAll()
        redView.backgroundColor = .gray
        yelowView.backgroundColor = .gray
        greenView.backgroundColor = .gray
    }
    
    @objc func settingTimeLight() {
        // Инициализируем экран из Storyboard
        if let settingsVC = storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController") as? SettingsTableViewController {
            // Выполняем push переход
            navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    @IBAction func actionButtom(_ sender: Any) {
        selectLight += 1
        selectTrafficLight()
    }
    
    func trafficLoghtView(_ view: UIView) {
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .gray
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
            selectLight += 1
            selectTrafficLight()
        }
    }
    
    func updateTimeLabel() {
        
        timeLabelRed.text?.removeAll()
        timeLabelYellow.text?.removeAll()
        timeLabelGreen.text?.removeAll()
        
        switch selectLight {
        case 0:
            timeLabelRed.text = String(format: "%02d", remainingSeconds)
            timeLabelRed.textColor = .black
        case 1:
            timeLabelYellow.text = String(format: "%02d", remainingSeconds)
            timeLabelYellow.textColor = .black
        case 2:
            timeLabelGreen.text = String(format: "%02d", remainingSeconds)
            timeLabelGreen.textColor = .black
        default:
            break
        }
    }
    
    @objc func selectTrafficLight() {
        
        // Сбрасываем все цвета
        redView.backgroundColor = .gray
        yelowView.backgroundColor = .gray
        greenView.backgroundColor = .gray
        
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

