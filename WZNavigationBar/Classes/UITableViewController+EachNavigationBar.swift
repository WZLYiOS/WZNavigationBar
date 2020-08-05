//
//  UITableViewController+EachNavigationBar.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - observation
extension UITableViewController {
    
    private var observation: NSKeyValueObservation {
        if let observation = objc_getAssociatedObject(
            self,
            &AssociatedKeys.observation)
            as? NSKeyValueObservation {
            return observation
        }
        
        let observation = tableView.observe(
        \.contentOffset,
        options: .new) { [weak self] tableView, change in
            guard let `self` = self else { return }
            
            self.view.bringSubviewToFront(self._navigationBar)
            self._navigationBar.frame.origin.y = tableView.contentOffset.y + Const.StatusBar.maxY
        }
        
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.observation,
            observation,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return observation
    }
    
    func observeContentOffset() {
        _navigationBar.automaticallyAdjustsPosition = false
        
        _ = observation
    }
}
