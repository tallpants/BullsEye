//
//  ViewController.swift
//  BullsEye
//
//  Created by Adithya Reddy on 14/07/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

func calculatePoints(hit: Int, target: Int) -> Int {
    return 100 - abs(hit - target)
}

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = Float(currentValue)
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        updateLabels()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func hit() {
        let points = calculatePoints(hit: currentValue, target: targetValue)
        score += points
        let message = "You hit: \(currentValue)!" + "\nPoints: \(points)"
        alert(message: message, then: { self.startNewRound() })
    }
    
    @IBAction func startOver() {
        round = 0
        score = 0
        currentValue = 0
        slider.value = 0
        startNewRound()
    }
    
    func alert(message: String, then: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in then?() }))
        present(alert, animated: true, completion: nil)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}
