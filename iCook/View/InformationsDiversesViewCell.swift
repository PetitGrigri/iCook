//
//  InformationsDiversesViewCell.swift
//  iCook
//
//  Created by Fabien on 01/01/2018.
//  Copyright © 2018 com.adamsha-griselles.ios. All rights reserved.
//

import UIKit

class InformationsDiversesViewCell: UITableViewCell {

    @IBOutlet weak var duree: UILabel!
    @IBOutlet weak var personnes: UILabel!
    @IBOutlet weak var prix: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
