//
//  Etape.swift
//  iCook
//
//  Created by Fabien on 07/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import Foundation


class Etape {
    var nom:String;
    var description:String;
    var duration:Int;
    
    
    public init(nom:String, andDescription description:String, andDuration duration:Int) {
        self.nom = nom
        self.description = description
        self.duration = duration
    }
    
    
}
