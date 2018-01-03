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
    @IBOutlet weak var tableauEtapes: UITableView!
    
    var recette:Recette? {
        didSet {
            self.numeroEtape = 0
        }
    }
    var numeroEtape:Int = 0
    let section = SectionWithImage(nom: "Liste des étapes", withImage: #imageLiteral(resourceName: "cooking"))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableauEtapes.delegate = self
        tableauEtapes.dataSource = self
        tableauEtapes.rowHeight = UITableViewAutomaticDimension
        tableauEtapes.estimatedRowHeight = UITableViewAutomaticDimension

        /*
        //etapeSuivanteButton.contentHorizontalAlignment = .left
        print("Image : \(etapeSuivanteButton.currentImage?.description)")

        let widthButton = etapeSuivanteButton.frame.width
        let widthLabel = etapeSuivanteButton.titleLabel?.text
        
        print("\n\nButton : \(widthButton), Label : \(widthLabel)\n\n")
        
        etapeSuivanteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:widthButton/2)
         */
 
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("WCSession is supported")
        }
        afficherEtape(numeroEtape:0)
        
        //TODO
    }

    
    @IBAction func touchEtapeSuivante(_ sender: Any) {
        etapeSuivante()
    }
    
    func afficherEtape(numeroEtape:Int) {
        
        print("Affichage de l'étape : \(numeroEtape)")
        
        //mémorisation de la ligne de tableau sélectionnée actuellement
        let etapeOldIndexPath = IndexPath.init(row: self.numeroEtape, section: 0)
        
        //si il n'y pas de recette ou d'étape valide, inutile de continuer
        guard
            let recette = self.recette,
            numeroEtape < recette.etapes.count,
            numeroEtape >= 0
            else {return}
        
        //mémorisation de la prochaine étape
        self.numeroEtape = numeroEtape

        //initialisation des variables qui seront utilisées
        var rowsToRefresh:[IndexPath]   = [IndexPath]()

        DispatchQueue.main.async {
            
            // envoyer les informations à la montre
            let session = WCSession.default
            
            guard session.isPaired && session.isWatchAppInstalled else {
                self.showToast(message: "Watch error")
                return
            }
            
            session.sendMessage([
                "etape":        recette.etapes[numeroEtape].numeroEtape,
                "description":  recette.etapes[numeroEtape].description,
                "duree":        recette.etapes[numeroEtape].duration
                ], replyHandler: { ([String : Any]) in
                    
            })
            
            /*session.transferUserInfo([
                "etape":        recette.etapes[numeroEtape].numeroEtape,
                "description":  recette.etapes[numeroEtape].description,
                "duree":        recette.etapes[numeroEtape].duration
                ])*/
            
            self.numeroEtapeLabel.text = String(recette.etapes[numeroEtape].numeroEtape)

            //scroll à l'étape en cours
            let etapeIndexPath = IndexPath.init(row: numeroEtape, section: 0)
            
            print("Actual : \(etapeIndexPath)")
            

            if self.numeroEtape >= recette.etapes.count {
                self.etapeSuivanteButton.setTitle("Terminé", for: .normal)
            } else {
                self.etapeSuivanteButton.setTitle("Prochaine Etape", for: .normal)

                rowsToRefresh.append(IndexPath.init(row: self.numeroEtape, section: 0))
                
                if etapeOldIndexPath.row < recette.etapes.count {
                    rowsToRefresh.append(etapeOldIndexPath)
                }
                //raffraichissement de l'affichage de la case
                self.tableauEtapes.reloadRows(at: rowsToRefresh, with: .fade)
                self.tableauEtapes.scrollToRow(at: etapeIndexPath, at: .top, animated: true)
            }
        }
    }
    
    //Fonction permettant de passer à l'étape suivante
    func etapeSuivante()
    {
        //si il n'y pas de recette, inutile de continuer
        guard
            let recette = self.recette,
            self.numeroEtape < recette.etapes.count
            else { return }
        
       let prochaineEtape = self.numeroEtape+1
        
        //affichage et sélection de l'étape en cours
        afficherEtape(numeroEtape:prochaineEtape)
    }
    
    //Fonction permettant de passer à l'étape precedente
    func etapePrecedente() {
        //si il n'y pas de recette, inutile de continuer
        guard
            let recette = self.recette,
            self.numeroEtape > 0
            else { return }
        
        let prochaineEtape = self.numeroEtape-1
        
        //affichage et sélection de l'étape en cours
        afficherEtape(numeroEtape:prochaineEtape)
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


extension CuisinerController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recette = self.recette else {
            return 0
        }
        
        return recette.etapes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recette = self.recette else {
            return UITableViewCell()
        }

        if indexPath.row == numeroEtape {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EtapeEnCours", for: indexPath) as? EtapeEnCoursViewCell {
                cell.etapeLabel.text = String(recette.etapes[indexPath.row].numeroEtape)
                cell.descriptionLabel.text = recette.etapes[indexPath.row].description
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EtapeNormale", for: indexPath) as? EtapeNormaleViewCell {
                cell.etapeLabel.text = String(recette.etapes[indexPath.row].numeroEtape)
                cell.descriptionLabel.text = recette.etapes[indexPath.row].description
                
                return cell
            }
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.afficherEtape(numeroEtape: indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let sectionRecette = Bundle.main.loadNibNamed("SectionDescriptionView", owner: self, options: nil)?.first as? SectionDescriptionView {
            
            //enregistrement de la recette dans la vue
            sectionRecette.titre.text = self.section.nom
            sectionRecette.image.image = self.section.image
            
            return sectionRecette
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension UIViewController {
    
    //show Android style toast msg
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


