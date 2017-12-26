//
//  RingProgressBarController.swift
//  iCook WatchKit Extension
//
//  Created by Asif on 26/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import WatchKit
import Foundation


class RingProgressBarController: WKInterfaceController {

    @IBOutlet var skScene: WKInterfaceSKScene!
    
    var ring:SKRingNode!
    var position = 1.0 // start from top (100 %)
    var durationInMin:Double = 1.0 // default duration to 60 sec
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        // do reverse ring progress bar
        
        let scene = GameScene(size: contentFrame.size)
        skScene.presentScene(scene)
        
        ring = SKRingNode(diameter: contentFrame.width)
        ring.position = CGPoint(x: contentFrame.midX, y: contentFrame.midY - 20)
        ring.arcEnd = CGFloat(position)
        
        // set duration
        durationInMin = 2.0
        
        print(getPositionStep())
        
        scene.addChild(ring)
        
        startTimer()
        
        //setTitle(ringType?.simpleDescription)
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func startTimer() -> Void {
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    func getPositionStep() -> Double {
        let durationToSec = durationInMin * 60
        return 1.0/durationToSec
    }
    
    @objc func update() {
        
        print("Position : \(position)")
        
        // 1.0 => 100 %
        if(position >= 0.0){
            position -= getPositionStep()
            ring.arcEnd = CGFloat(position)
        }
    }
    
}
