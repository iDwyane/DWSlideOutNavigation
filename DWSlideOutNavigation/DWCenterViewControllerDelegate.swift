//
//  DWCenterViewControllerDelegate.swift
//  DWSlideOutNavigation
//
//  Created by Dwyane on 2017/11/20.
//  Copyright © 2017年 DWade. All rights reserved.
//

import UIKit

//创建协议 optional：类似oc的可选
@objc
protocol DWCenterViewControllerDelegate {
    @objc optional func toggleLeftPanel()  //切换左边的容器
    @objc optional func collapseSidePanels() //折叠侧边的容器
}
