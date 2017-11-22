//
//  DWStar.swift
//  DWSlideOutNaviation
//
//  Created by Dwyane on 2017/11/16.
//  Copyright © 2017年 DWade. All rights reserved.
//

import UIKit

struct DWStar {
    let title: String
    let creator: String
    let image: UIImage?
    
    init(title: String, creator: String, image:UIImage?) {
        self.title = title
        self.creator = creator
        self.image = image
    }
    
    static func allActors() -> [DWStar] {
        return [
            DWStar(title: "林志玲", creator: "Dwyane", image: UIImage(named: "ID-100113060")),
            DWStar(title: "张歆艺", creator: "Dwyane", image: UIImage(named: "ID-10022760")),
            DWStar(title: "李连杰", creator: "Dwyane", image: UIImage(named: "ID-10091065")),
            DWStar(title: "周润发", creator: "Dwyane", image: UIImage(named: "ID-10047796")),
            DWStar(title: "舒淇", creator: "Dwyane", image: UIImage(named: "ID-10092572")),
            DWStar(title: "鹿晗", creator: "Dwyane", image: UIImage(named: "ID-10041194")),
            DWStar(title: "黄晓明", creator: "Dwyane", image: UIImage(named: "ID-10017782")),
            DWStar(title: "李赛凤", creator: "Dwyane", image: UIImage(named: "ID-10091745")),
            DWStar(title: "赵丽颖", creator: "Dwyane Ratcliff", image: UIImage(named: "ID-10056941")),
            DWStar(title: "周星驰", creator: "Dwyane", image: UIImage(named: "ID-10019208")),
            DWStar(title: "杜海涛", creator: "Dwyane", image: UIImage(named: "ID-10011404"))
        ]
    }
    
  
    
}

