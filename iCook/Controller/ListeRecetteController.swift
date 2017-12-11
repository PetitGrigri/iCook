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
        listeRecettes.append(Recette(
            nom: "Tarte au citron meringuée",
            description: "La tarte au citron meringuée est une tarte au citron complétée par une meringue. C'est une tarte sucrée garnie de crème à base de citron. Elle ne comprend aucun fruit. La crème est un mélange d'œufs, de sucre, de jus de citron et de zeste de citron",
            image: #imageLiteral(resourceName: "Slide1")))
        listeRecettes.append(Recette(
            nom: "Tiramisu (recette originale)",
            description: "Le tiramisu est une pâtisserie et un dessert traditionnel de la cuisine italienne.",
            image: #imageLiteral(resourceName: "Slide2")))
       
        self.tabBarItem = UITabBarItem(title: "Recette", image: #imageLiteral(resourceName: "Book"), selectedImage: #imageLiteral(resourceName: "Book"))

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
                //remplissage de notre view
                viewRecette.desciptionRecette.text = recette.description
                viewRecette.titreRecette.text = recette.nom
                viewRecette.imageRecette.image = recette.image
                
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
}

extension ListeRecetteController : UIScrollViewDelegate {
    
}
