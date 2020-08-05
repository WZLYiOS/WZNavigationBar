//
//  UIViewController+Associated.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ObjectiveC

/// MARK - UINavigationController + associated
extension UINavigationController {
    
    var _configuration: Configuration {
        if let configuration = objc_getAssociatedObject(
            self,
            &AssociatedKeys.configuration)
            as? Configuration {
            return configuration
        }
        let configuration = Configuration()
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.configuration,
            configuration,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return configuration
    }
}

/// MARK - UIViewController + associated
extension UIViewController {
    
    var _navigationBar: EachNavigationBar {
        if let bar = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationBar)
            as? EachNavigationBar {
            return bar
        }
        
        let bar = EachNavigationBar(viewController: self)
        
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.navigationBar,
            bar,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    var _navigationItem: UINavigationItem {
        if let item = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationItem)
            as? UINavigationItem {
            return item
        }
        
        let item = UINavigationItem()
        item.copy(by: navigationItem)
        
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.navigationItem,
            item,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
}

/// MARK - UINavigationItem copy
private extension UINavigationItem {
    
    func copy(by navigationItem: UINavigationItem) {
        self.title = navigationItem.title
        self.prompt = navigationItem.prompt
    }
}

