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

    @IBOutlet weak var numeroEtapeLabel: UILabel!
    @IBOutlet weak var etapeSuivanteButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var recette:Recette?
    var numeroEtape:Int
    
    required init?(coder aDecoder: NSCoder) {
        self.numeroEtape = 0
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("WCSession is supported")
        }
        etapeSuivante()
    }

    @IBAction func touchEtapeSuivante(_ sender: Any) {
        etapeSuivante()
    }
    
    //Fonction permettant de passer à l'étape suivante
    func etapeSuivante() {
        var hasWatchkit = false
        
        let session = WCSession.default
        
        //on regarde si la montre est appairée
        if (session.isPaired && session.isWatchAppInstalled) {
            hasWatchkit = true
        }
        
        guard let recette = self.recette else { return }

        if self.numeroEtape < recette.etapes.count {
            numeroEtapeLabel.text = String(recette.etapes[numeroEtape].numeroEtape)
            descriptionLabel.text = recette.etapes[numeroEtape].description
            
            if hasWatchkit == true {
                print("transmission à la montre")
                session.transferUserInfo([
                    "etape":        recette.etapes[numeroEtape].numeroEtape,
                    "description":  recette.etapes[numeroEtape].description,
                    "temps":        recette.etapes[numeroEtape].duration,
                    ])
            } else {
                print("transmission à la montre")
            }
        } else {
            print("Terminé")
            etapeSuivanteButton.titleLabel?.text = "Terminé"
            descriptionLabel.text = ""
        }
        numeroEtape = numeroEtape + 1
    }
    
}




extension CuisinerController:WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage")
    }
    
    
    
}


