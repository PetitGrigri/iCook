//
//  RecetteFactory.swift
//  iCook
//
//  Created by Fabien on 31/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import Foundation

class RecetteFactory {
    
    static func createTiramisu() -> Recette {
        
        let recette = Recette(
            nom: "Tiramisu (recette originale)",
            description: "Le tiramisu est une pâtisserie et un dessert traditionnel de la cuisine italienne.",
            image: #imageLiteral(resourceName: "Slide2"),
            prix: "Bon marché",
            personnes:8,
            duree:15
            )

        recette.ingredients = [
            Ingredient(nom: "Oeufs", withQuantite: 3, withUnite: ""),
            Ingredient(nom: "Sucre roux", withQuantite: 100, withUnite: "g"),
            Ingredient(nom: "Mascarpone", withQuantite: 250, withUnite: "g"),
            Ingredient(nom: "Biscuits à la cuillère", withQuantite: 24, withUnite: ""),
            Ingredient(nom: "Cacao amer", withQuantite: 30, withUnite: "g")
        ]
        
        recette.ustensiles = [
            Ustensile(nom: "Cuillère en bois", withQuantite: 1),
            Ustensile(nom: "Fouet", withQuantite: 1),
            Ustensile(nom: "Spatule", withQuantite: 1),
            Ustensile(nom: "Saladier", withQuantite: 1),
            Ustensile(nom: "Couvercle", withQuantite: 1),
            Ustensile(nom: "Réfrigérateur", withQuantite: 1)
        ]
        
        recette.etapes = [
            Etape(numeroEtape: 1, andDescription: "Séparer les blancs des jaunes d'oeufs. ", andDuration: 1),
            Etape(numeroEtape: 2, andDescription: "Mélanger les jaunes avec le sucre roux et le sucre vanillé.", andDuration: 2),
            Etape(numeroEtape: 3, andDescription: "Ajouter le mascarpone au fouet. ", andDuration: 3),
            Etape(numeroEtape: 4, andDescription: "Monter les blancs en neige et les incorporer délicatement à la spatule au mélange précédent. Réserver.", andDuration: 4),
            Etape(numeroEtape: 5, andDescription: "Mouiller les biscuits dans le café rapidement avant d'en tapisser le fond du plat.", andDuration: 2),
            Etape(numeroEtape: 6, andDescription: "Recouvrir d'une couche de crème au mascarpone puis répéter l'opération en alternant couche de biscuits et couche de crème en terminant par cette dernière.", andDuration: 2),
            Etape(numeroEtape: 7, andDescription: "Saupoudrer de cacao.", andDuration: 1),
            Etape(numeroEtape: 8, andDescription: "Mettre au réfrigérateur 4 heures minimum puis déguster frais.", andDuration: 240)
        ]
        return recette
        
    }
    
    static func createTarteCitron() -> Recette {
        
        let recette = Recette(
            nom: "Tarte au citron meringuée",
            description: "La tarte au citron meringuée est une tarte au citron complétée par une meringue. C'est une tarte sucrée garnie de crème à base de citron. Elle ne comprend aucun fruit. La crème est un mélange d'œufs, de sucre, de jus de citron et de zeste de citron",
            image: #imageLiteral(resourceName: "Slide1"),
            prix: "Bon marché",
            personnes:6,
            duree:55)
        
        return recette
    }
    
}
