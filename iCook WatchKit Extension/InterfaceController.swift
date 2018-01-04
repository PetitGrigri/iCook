//
//  InterfaceController.swift
//  iCook WatchKit Extension
//
//  Created by Fabien on 02/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var etapeNumLabel: WKInterfaceLabel!
    @IBOutlet var descriptionEtapeLabel: WKInterfaceLabel!
    @IBOutlet var timerButton: WKInterfaceButton!
    @IBOutlet var nextButton: WKInterfaceButton!
    @IBOutlet var logoImage: WKInterfaceImage!
    
    var etapeCourante:Int = 0
    var isLogoHidden:Bool = false
    var duration:Double = 0
    
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        
        showWelcomeLogo(setVisible: true)
        
        if WCSession.isSupported() {
            print("supported")
            let session = WCSession.default
            session.delegate = self
            session.activate()
            raffraichir()
        }
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func touchTimerButton() {
        pushController(withName: "ProgressRing", context: duration)
    }
    
    @IBAction func touchNextButton() {
        let session = WCSession.default
        guard session.isReachable else { return }
        
        session.sendMessage(["action":"prochaine_etape"], replyHandler: nil) { (error) in
            print(error)
        }
    }
    
    func raffraichir() {
        let session = WCSession.default
        guard session.isReachable else { return }
        
        
        print("tentative de raffraichissement")
        session.sendMessage(["action":"etape_courante"], replyHandler: nil) { (error) in
            print(error)
        }
    }
    
    func showWelcomeLogo(setVisible:Bool) {
        
        if(setVisible){
            self.timerButton.setHidden(true)
            self.nextButton.setHidden(true)
            self.etapeNumLabel.setHidden(true)
            self.descriptionEtapeLabel.setHidden(true)
            self.logoImage.setHidden(false)
        } else{
            self.timerButton.setHidden(false)
            self.timerButton.setEnabled(false)
            self.nextButton.setHidden(false)
            self.etapeNumLabel.setHidden(false)
            self.descriptionEtapeLabel.setHidden(false)
            self.logoImage.setHidden(true)
            self.isLogoHidden = true
        }
        
    }
    
}


extension InterfaceController:WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith : \(activationState)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        DispatchQueue.main.async {
            
            guard   let etape   = message["etape"] as? Int,
                let desc    = message["description"] as? String,
                let duree   = message["duree"] as? Double else {
                    return
            }
            
            let etapeTxt = "Étape : \(etape)"
            
            print("watch etape : \(etape)")
            print("watch desc : \(desc)")
            print("watch duree : \(duree)")
            
            self.etapeNumLabel.setText(etapeTxt)
            self.descriptionEtapeLabel.setText(desc)
            
            if(!self.isLogoHidden) {
                self.showWelcomeLogo(setVisible: false)
            }
            
            //set timer button state
            if(duree > 0){
                self.duration = duree // set time
                self.timerButton.setEnabled(true)
            } else {
                self.timerButton.setEnabled(false)
            }
            
            //todo : reply handler to complete
        }
        
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
       
       // self.image.setImageData(data)
    }
}

