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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let trafficLightViews: [UIView] = [redView, yelowView, greenView]
//        
//        for view in trafficLightViews {
//            trafficLoghtView(view)
        }
        
        override func viewDidLayoutSubviews() {
               super.viewDidLayoutSubviews()
               
               // Массив для удобства обработки
               let trafficLightViews: [UIView] = [redView, yelowView, greenView]
               
               for view in trafficLightViews {
                   view.frame.size = CGSize(width: 200, height: 200)
                   trafficLoghtView(view)
               }
           }
        

    @IBAction func actionButtom(_ sender: Any) {
    }
    
    func trafficLoghtView(_ view: UIView) {
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .clear
    }
    

}

