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

    @IBOutlet var etapeNum: WKInterfaceLabel!
    @IBOutlet var descriptionEtape: WKInterfaceLabel!
    
    var etapeCourante:Int = 0
    
    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        print("tentative d'activer la session (Watch)")
        if WCSession.isSupported() {
            print("OK")
            let session = WCSession.default
            session.delegate = self
            session.activate()
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
        pushController(withName: "ProgressRing", context: nil)
    }
    
    @IBAction func touchNextButton() {
        print("//TODO")
        let session = WCSession.default
        guard session.isReachable else { return }
        
        session.sendMessage(["prochaine_etape":true], replyHandler: nil) { (error) in
            print(error)
        }
    }
    
}





extension InterfaceController:WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(activationState)
    }
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("tentative de reception")
        print(userInfo)
        
        guard let etape = userInfo["etape"] as? Int else {
            print("retour")
            return
        }
        print("tentative 2 de reception")
        
        guard let desc = userInfo["description"] as? String else {
            print("retour")
            return
        }
        
        let etapeTxt = "Étape : \(etape)"
        
        self.etapeNum.setText(String(etapeTxt))
        self.descriptionEtape.setText(desc)
        
    }
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
       
       // self.image.setImageData(data)
    }
    
}

