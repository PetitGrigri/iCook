//
//  RecetteDescriptionController.swift
//  iCook
//
//  Created by Fabien on 31/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import UIKit

class RecetteDescriptionController: UITableViewController  {

    var recette:Recette?
    
    let sections:[SectionWithImage] = [
        SectionWithImage(nom: "Ingrédients", withImage: #imageLiteral(resourceName: "ingredients")),
        SectionWithImage(nom: "Ustensiles", withImage: #imageLiteral(resourceName: "ustensiles")),
        SectionWithImage(nom: "Informations complémentaires", withImage: nil),
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    /*
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section]
    }*/
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print("viewForHeaderInSection : \(section)")
        
        if let sectionRecette = Bundle.main.loadNibNamed("SectionDescriptionView", owner: self, options: nil)?.first as? SectionDescriptionView {
            
            //enregistrement de la recette dans la vue
            sectionRecette.titre.text = sections[section].nom
            sectionRecette.image.image = sections[section].image
            
            return sectionRecette
        }

        return nil
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
