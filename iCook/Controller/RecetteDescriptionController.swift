//
//  RecetteDescriptionController.swift
//  iCook
//
//  Created by Fabien on 31/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import UIKit

class RecetteDescriptionController: UIViewController {

    var recette:Recette?


    @IBOutlet weak var imageRecette: UIImageView!
    @IBOutlet weak var tableau: UITableView!
    
    let sections:[SectionWithImage] = [
        SectionWithImage(nom: "Ingrédients", withImage: #imageLiteral(resourceName: "ingredients")),
        SectionWithImage(nom: "Ustensiles", withImage: #imageLiteral(resourceName: "ustensiles")),
        SectionWithImage(nom: "Informations complémentaires", withImage: nil),
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableau.delegate = self
        tableau.dataSource = self
        imageRecette.image = recette?.image
        self.title = recette?.nom
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DescriptionToCuisiner") {
            if let destinationController = segue.destination as? CuisinerController {
                destinationController.recette = self.recette
            }
        }
    }

}

extension RecetteDescriptionController:UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recette = self.recette else {
            return 0
        }
        if (section == 0) {
            return recette.ingredients.count
        } else if (section == 1){
            return recette.ustensiles.count
        } else if (section == 2){
            return 1
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        switch (indexPath.section) {
        case 0 :
            cell.textLabel?.text = recette!.ingredients[indexPath.row].nom
            cell.detailTextLabel?.text = "\(recette!.ingredients[indexPath.row].quantite) \((recette!.ingredients[indexPath.row].unite))"
            break
        case 1 :
            
            cell.textLabel?.text = recette!.ustensiles[indexPath.row].nom
            cell.detailTextLabel?.text = String(recette!.ustensiles[indexPath.row].quantite)
            break
        case 2 :
            if let cellInformations = tableView.dequeueReusableCell(withIdentifier: "InformationsDiverses", for: indexPath) as? InformationsDiversesViewCell {
                cellInformations.prix.text = self.recette!.prix
                cellInformations.personnes.text = String(self.recette!.personnes)
                cellInformations.duree.text = "\(self.recette!.duree) min"
                return cellInformations
            }
            
            
            break
        default:
            
            break
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let sectionRecette = Bundle.main.loadNibNamed("SectionDescriptionView", owner: self, options: nil)?.first as? SectionDescriptionView {
            
            //enregistrement de la recette dans la vue
            sectionRecette.titre.text = sections[section].nom
            sectionRecette.image.image = sections[section].image
            
            return sectionRecette
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

