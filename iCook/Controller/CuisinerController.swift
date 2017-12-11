//
//  CuisinerController.swif
//  iCook
//
//  Created by Fabien on 03/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//


import Foundation
import UIKit
import WatchConnectivity

class CuisinerController : UIViewController
{
    let etapes = [
        "Mélanger le sucre, la farine, la levure et les oeufs.",
        "Faire fondre le beurre.",
        "Mélanger le beurre fondu avec le mélange farine-sucre-oeuf-levure.",
        "Mettre au four à 175°C (th6) pendant 40 à 45 minutes."
    ]
    
    var numeroEtape:Int = 0
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tabBarItem = UITabBarItem(title: "Recette", image: #imageLiteral(resourceName: "cooking"), selectedImage: #imageLiteral(resourceName: "cooking"))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Activation de la connectivity avec WatchConnectivity
        print("tentative de connexion")
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("ok")
            /*
             if WCSession.default.isPaired && WCSession.default.isWatchAppInstalled {
             
             }*/
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func touch(_ sender: Any) {
        
        let session = WCSession.default
        var hasWatchkit = false
        
        if (session.isPaired && session.isWatchAppInstalled) {
            hasWatchkit = true
        }
        
        switch numeroEtape {
            
        case 4:
            print("Terminé")
            break
        default:
            print("Etape \(numeroEtape) :\n \(etapes[numeroEtape])")
            
            if hasWatchkit == true{
                print("transmission à la montre")
                session.transferUserInfo([
                    "etape":        numeroEtape,
                    "description":  etapes[numeroEtape]
                    ])
            } else {
                print("PAS de transmission à la montre")
            }
            
            numeroEtape = numeroEtape + 1
        }
        
        
        
    }
    
    
}




extension CuisinerController:WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}


