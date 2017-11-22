//
//  DWContainerViewController.swift
//  DWSlideOutNavigation
//
//  Created by Dwyane on 2017/11/21.
//  Copyright © 2017年 DWade. All rights reserved.
//

import UIKit

class DWContainerViewController: UIViewController {

    
    //枚举  滑动状态
    enum SlideOutState {
        case bothCollapsed  //侧容器折叠
        case leftPanelExpanded   //左容器展开
        case rightPanelExpanded  //右容器展开
    }
    
    //定义属性
    var centerNavigationController: UINavigationController!
    var centerViewController: DWCenterViewController!
    //当前状态
    var currentState: SlideOutState = .bothCollapsed {
        didSet { //在属性值改变后触发didSet
            let shoulShowShadow = currentState != .bothCollapsed
        }
    }
    
    var leftViewController: DWSidePanelViewController?
    var centerPanelExpandedOffset: CGFloat = 60 //该值是中央视图控制器在屏幕外动画显示后左侧可见的宽度（以点为单位）
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //添加中间控制器并显示
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        //将centerViewController包装在导航控制器中
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        //加入centerViewcontroller的视图
        view.addSubview(centerNavigationController.view)
        //加入centerViewcontroller的视图控制器
        addChildViewController(centerNavigationController)
        centerNavigationController.didMove(toParentViewController: self)
        
        //为中间控制器添加手势，用于左侧的折叠展开
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }

}


//MARK: DWCenterViewController delegate
extension DWContainerViewController: DWCenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        //如果当前状态：左边为展开
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController() //添加左边容器
        }
        //左边容器展开的动画
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    //折叠侧边容器
    func collapseSidePanels() {
        switch currentState {
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    
    //左边的VC
    func addLeftPanelViewController() {//guard语句判断其后的表达式布尔值为false时，才会执行之后代码块里的代码，如果为true，则跳过整个guard语句
        guard leftViewController == nil else { return }
        
        if let vc = UIStoryboard.leftViewController() {
            vc.stars = DWStar.allActors()
            addChildSidePanelController(vc)
            leftViewController = vc
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: DWSidePanelViewController) {
        sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    
    //右边的VC
    func addRightPanelViewController() {
        
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0, completion: { (_) in
                self.currentState = .bothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            })
        }
    }
    
    //检查是否被告知展开或折叠侧面板。如果它应该展开，那么它将设置当前状态以指示左侧面板展开，然后为中央面板设置动画，以便打开。否则，它将关闭中央面板，然后移除其视图，并设置当前状态以指示其关闭。
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}


// 手势
// MARK: Gesture recognizer
extension DWContainerViewController: UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ recognize: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognize.velocity(in: view).x > 0)
        
        switch recognize.state {
        case .began:
            if currentState == .bothCollapsed {
                if gestureIsDraggingFromLeftToRight {
                    //左边
                    addLeftPanelViewController()
                } else {
                    //右边
                    addRightPanelViewController()
                }
                showShadowForCenterViewController(true)
            }
        case .changed:
            if let rview = recognize.view {
                rview.center.x = rview.center.x + recognize.translation(in: view).x
                recognize.setTranslation(CGPoint.zero, in: view)
                //translationInView:方法获取View的偏移量  setTranslation:方法设置手势的偏移量
            }
        case .ended: //根据不同的方向移动左或右
            if let _ = leftViewController,
                let rview = recognize.view {
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
            
        default:
            break
        }
        
    }
}



private extension UIStoryboard {
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func centerViewController() -> DWCenterViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "DWCenterViewController") as? DWCenterViewController
    }
    
    static func leftViewController() -> DWSidePanelViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewController") as? DWSidePanelViewController
    }

    
}
