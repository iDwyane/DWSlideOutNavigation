//
//  DWCenterViewController.swift
//  DWSlideOutNavigation
//
//  Created by Dwyane on 2017/11/20.
//  Copyright © 2017年 DWade. All rights reserved.
//

import UIKit

class DWCenterViewController: UIViewController {

    var delegate: DWCenterViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
    @IBAction func actorsTapped(_ sender: Any) {
        //左边点击事件
        delegate?.toggleLeftPanel?()
    }

}

// MARK: - DWCenterViewController delegate
//在该类实现delegate的方法
extension DWCenterViewController: DWSidePanelViewControllerDelegate {
    func didSelectAnimal(_ animal: DWStar) { //实现协议方法
        imageView.image = animal.image
        titleLabel.text = animal.title
        creatorLabel.text = animal.creator
        
        delegate?.collapseSidePanels?() //折叠侧容器
    }
    
}
