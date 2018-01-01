//
//  ListeRecetteController.swift
//  iCook
//
//  Created by Fabien on 03/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//


import Foundation
import UIKit

class ListeRecetteController : UIViewController {
    
    //objet lié à la vue
    @IBOutlet weak var scrollView: UIScrollView!

    //les recettes
    var listeRecettes:[Recette] = [Recette]()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        listeRecettes.append(RecetteFactory.createTiramisu())
        listeRecettes.append(RecetteFactory.createTarteCitron())

        //self.tabBarItem = UITabBarItem(title: "Recette", image: #imageLiteral(resourceName: "Book"), selectedImage: #imageLiteral(resourceName: "Book"))

    }
    
    
    override func viewDidLoad()
    {
        //récupération de la taille de la view principale
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)

        
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height

        for (index,recette) in listeRecettes.enumerated() {

            print(recette.nom)
            print(index)

            if let viewRecette = Bundle.main.loadNibNamed("RecetteScrollItemView", owner: self, options: nil)?.first as? RecetteScrollItemView {
                
                //enregistrement de la recette dans la vue
                viewRecette.recette = recette

                viewRecette.delegate = self
                
                //affichage de notre vue sur toute la surface disponible
                viewRecette.frame.size.width = scrollViewWidth
                viewRecette.frame.size.height = scrollViewHeight

                //positionnement de notre vue (on fait en sorte qu'elle soit à la suite)
                viewRecette.frame.origin.x = CGFloat(index) * scrollViewWidth
                self.scrollView.addSubview(viewRecette)
            }
        }

        //scrollView.isPagingEnabled = true

        self.scrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(listeRecettes.count), height: scrollViewHeight)


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ListeToDescription") {
            guard
                let destinationController = segue.destination as? RecetteDescriptionController,
                let recette = sender as? Recette else{
                return
            }
            destinationController.recette = recette
        }
    }
}


extension ListeRecetteController : UIScrollViewDelegate {
    
}

extension ListeRecetteController : TouchProtocol {
    func touch(recette: Recette) {
        performSegue(withIdentifier: "ListeToDescription", sender: recette)

    }
}
