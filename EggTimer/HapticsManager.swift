//
//  HapticsManager.swift
//  EggTimer
//
//  Created by Santiago Hernandez on 3/4/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

    // Haptic feedback class from iOS Academy on YouTube: https://youtu.be/GgqQXiOI6gY
final class HapticsManager {
    
    //Final class for security, so it cannot be made into a subclass
    static let shared = HapticsManager()
    
    private init() {
        //This constructor is only accessible by the shared instance
    }
    
    public func selectionVibrate() {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.prepare()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
    
}
