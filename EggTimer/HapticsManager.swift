//
//  HapticsManager.swift
//  EggTimer
//
//  Created by Santiago Hernandez on 3/4/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit


final class HapticsManager {
    static let shared = HapticsManager()
    
    private init() {
        
    }
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
    
}
