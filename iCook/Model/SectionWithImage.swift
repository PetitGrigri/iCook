//
//  SectionWithImage.swift
//  iCook
//
//  Created by Fabien on 31/12/2017.
//  Copyright © 2017 com.adamsha-griselles.ios. All rights reserved.
//

import Foundation
import UIKit

class SectionWithImage {
    var nom:String;
    var image:UIImage?;

    
    public init(nom:String,  withImage image:UIImage?) {
        self.nom = nom
        self.image = image
    }
    
}
