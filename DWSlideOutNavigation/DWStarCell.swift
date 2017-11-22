//
//  DWStarCell.swift
//  DWSlideOutNavigation
//
//  Created by Dwyane on 2017/11/20.
//  Copyright © 2017年 DWade. All rights reserved.
//

import UIKit

class DWStarCell: UITableViewCell {
    
   
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageCreatorLabel: UILabel!

    func configureForAnimal(_ animal: DWStar) {
        animalImageView.image = animal.image
        imageNameLabel.text = animal.title
        imageCreatorLabel.text = animal.creator
    }
    
}

