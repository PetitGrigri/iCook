//
//  RecetteDescriptionController.swift
//  iCook
//
//  Created by Fabien on 31/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import UIKit

class RecetteDescriptionController: UITableViewController  {

    let sections:[String] = ["Ingrédients", "Ustensiles", "Détail"]
    
    let ingredients:[Ingredient] = [
        Ingredient(nom: "Oeufs", withQuantite: 3, withUnite: ""),
        Ingredient(nom: "Sucre roux", withQuantite: 100, withUnite: "g"),
        Ingredient(nom: "Mascarpone", withQuantite: 250, withUnite: "g"),
        Ingredient(nom: "Biscuits à la cuillère", withQuantite: 24, withUnite: ""),
        Ingredient(nom: "Cacao amer", withQuantite: 30, withUnite: "g")
    ]
    
    let ustensiles:[Ustensile] = [
        Ustensile(nom: "Cuillère en bois", withQuantite: 1),
        Ustensile(nom: "Fouet", withQuantite: 1),
        Ustensile(nom: "Spatule", withQuantite: 1),
        Ustensile(nom: "Saladier", withQuantite: 1),
        Ustensile(nom: "Couvercle", withQuantite: 1),
        Ustensile(nom: "Réfrigérateur", withQuantite: 1)
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
        if (section == 0) {
            return ingredients.count
        } else if (section == 1){
            return ustensiles.count
        }
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section]
    }*/
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)

        switch (indexPath.section) {
            case 0 :
                cell.textLabel?.text = ingredients[indexPath.row].nom
                cell.detailTextLabel?.text = "\(ingredients[indexPath.row].quantite) \((ingredients[indexPath.row].unite))"
                break
            case 1 :
                cell.textLabel?.text = ustensiles[indexPath.row].nom
                cell.detailTextLabel?.text = String(ustensiles[indexPath.row].quantite)
                break
            case 2 :
                
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
            sectionRecette.titre.text = sections[section]

            sectionRecette.image.image = #imageLiteral(resourceName: "ustensiles")
            sectionRecette.image.frame.size.width = 44
            sectionRecette.image.frame.size.height = 44
            
            return sectionRecette
        }

        return nil
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
