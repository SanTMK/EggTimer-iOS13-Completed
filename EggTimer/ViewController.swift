//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
//  Edited by Santiago Hernandez on Mar. 4, 2022
//  Enhancements:
//    1) Added Haptic Feedback and vibrations
//    2) Added custom timer
//    3) Added ability to modify values of egg timers

import UIKit
import AVFoundation


class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    
    
    @IBOutlet weak var HardEggTime: UITextField!
    @IBOutlet weak var MediumEggTime: UITextField!
    @IBOutlet weak var SoftEggTime: UITextField!
    @IBOutlet weak var InputSeconds: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    var eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7, "Start": 0]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InputSeconds.delegate = self
        SoftEggTime.delegate = self
        MediumEggTime.delegate = self
        HardEggTime.delegate = self
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        HapticsManager.shared.selectionVibrate()
//        <-----Enhancement #2:----->
//        Include custom time parameter to eggTimes dictionary
        
        if sender.currentTitle == "Start" {
            eggTimes["Start"] = Int(InputSeconds.text!)
        }
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
//        <-----Enhancement #1:----->
//        Haptic feedback on completion of timer as well as button presses. See HapticsManager.swift file for details
            
            HapticsManager.shared.vibrate(for: .error)
        }
    }
    
    //        <-----Enhancement #3:----->
//    Added a way to customize the value of each timer individually
    
    @IBAction func clickNewTime(_ sender: UIButton) {
        HapticsManager.shared.selectionVibrate()
    
        if SoftEggTime.hasText {
            eggTimes["Soft"] = Int(SoftEggTime.text!)
        } else if MediumEggTime.hasText {
            eggTimes["Medium"] = Int(MediumEggTime.text!)
        }else if HardEggTime.hasText {
            eggTimes["Hard"] = Int(HardEggTime.text!)
        }
    
    }
    
//    Hide keyboard when pressing 'intro' key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        InputSeconds.resignFirstResponder()
        HardEggTime.resignFirstResponder()
        MediumEggTime.resignFirstResponder()
        SoftEggTime.resignFirstResponder()
        
        return true
    }
    
    
}
