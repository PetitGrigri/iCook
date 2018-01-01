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
    
    var recette:Recette? {
        didSet {
            self.numeroEtape = 0
        }
    }
    var numeroEtape:Int = 0
    
    required init?(coder aDecoder: NSCoder) {
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
        afficherEtape(numeroEtape:0)
    }

    
    @IBAction func touchEtapeSuivante(_ sender: Any) {
        etapeSuivante()
    }
    
    func afficherEtape(numeroEtape:Int) {
        //mémorisation de l'étape en cours
        self.numeroEtape = numeroEtape
        
        //si il n'y pas de recette, inutile de continuer
        guard let recette = self.recette else { return }
        
        //initialisation des variables qui seront utilisées
        var etapeAffichee:Int           = recette.etapes.count
        var descriptionAffichee:String  = "Bon appétit"
        var tempsAffiche:Int            = 0
        let session                     = WCSession.default
        var hasWatchkit                 = false
        var recetteTerminee             = true
        
        //on regarde si la montre est appairée
        if (session.isPaired && session.isWatchAppInstalled) {
            hasWatchkit = true
        }
        
        //si l'étape existe
        if numeroEtape < recette.etapes.count && numeroEtape >= 0 {
            etapeAffichee       = recette.etapes[numeroEtape].numeroEtape
            descriptionAffichee = recette.etapes[numeroEtape].description
            tempsAffiche        = recette.etapes[numeroEtape].duration
            recetteTerminee     = false
        }
        
        DispatchQueue.main.async {
            self.numeroEtapeLabel.text = String(etapeAffichee)
            self.descriptionLabel.text = descriptionAffichee
            if recetteTerminee {
                self.etapeSuivanteButton.setTitle("Terminé", for: .normal)
            }
        }
        
        if hasWatchkit == true {
            session.transferUserInfo([
                "etape":        etapeAffichee,
                "description":  descriptionAffichee,
                "duree":        tempsAffiche
                ])
        }
    }
    
    //Fonction permettant de passer à l'étape suivante
    func etapeSuivante()
    {
        //si il n'y pas de recette, inutile de continuer
        guard let recette = self.recette else { return }
        
        //vérification de la cohérence de l'incrémentation
        if numeroEtape <= recette.etapes.count {
            self.numeroEtape+=1
        }
        afficherEtape(numeroEtape:self.numeroEtape)
    }
    
    //Fonction permettant de passer à l'étape suivante
    func etapePrecedente() {
        if numeroEtape > 0 {
            self.numeroEtape-=1
        }
        
        afficherEtape(numeroEtape:self.numeroEtape)
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
        
        print("didReceiveMessage : \n \(message)")
        
        if let action = message["action"] as? String {
            if action == "prochaine_etape" {
                etapeSuivante()
            }
            else if action == "etape_courante" {
                afficherEtape(numeroEtape: self.numeroEtape)
            }
        }
    }
}


