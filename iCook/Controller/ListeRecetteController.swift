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
    @IBOutlet weak var recettesScrollView: UIScrollView!
    @IBOutlet weak var recettesPageControl: UIPageControl!
    
    //les recettes
    var listeRecettes:[Recette] = [Recette]()
    var pageVisualiseeEnCours = 0 {
        didSet {
            if (self.pageVisualiseeEnCours >= self.listeRecettes.count) {
                pageVisualiseeEnCours = self.listeRecettes.count - 1
            }
            if (self.pageVisualiseeEnCours < 0) {
                pageVisualiseeEnCours = 0
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        listeRecettes.append(RecetteFactory.createTiramisu())
        listeRecettes.append(RecetteFactory.createTarteCitron())
        listeRecettes.append(RecetteFactory.createTiramisu())
        listeRecettes.append(RecetteFactory.createTarteCitron())
    }
    
    
    override func viewDidLoad()
    {
        self.recettesScrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)

        let scrollViewWidth:CGFloat = self.recettesScrollView.frame.width
        let scrollViewHeight:CGFloat = self.recettesScrollView.frame.height
        
        recettesScrollView.delegate = self
        //TODO voir si on peut utiliser un autoDimension de iOS 11
        

        recettesPageControl.numberOfPages = listeRecettes.count
        
        
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
                self.recettesScrollView.addSubview(viewRecette)
            }
        }

        //scrollView.isPagingEnabled = true

        self.recettesScrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(listeRecettes.count), height: scrollViewHeight)


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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        self.pageVisualiseeEnCours = Int((recettesScrollView.contentOffset.x / recettesScrollView.frame.width).rounded())
        self.recettesPageControl.currentPage = self.pageVisualiseeEnCours
    }
    
    func refresh(_ scrollView: UIScrollView) {
        self.pageVisualiseeEnCours = Int((recettesScrollView.contentOffset.x / recettesScrollView.frame.width).rounded())

        let offsetPage = CGPoint(x: (CGFloat(self.pageVisualiseeEnCours) * recettesScrollView.frame.width), y: -64)
        
        recettesScrollView.setContentOffset(offsetPage, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refresh(scrollView)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        refresh(scrollView)
    }
    

    
}

extension ListeRecetteController : TouchProtocol {
    func touch(recette: Recette) {
        performSegue(withIdentifier: "ListeToDescription", sender: recette)
        
        

    }
}
