//
//  UIViewController+Navigation.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - extension
public extension Navigation where Base: UIViewController {
    
    var bar: EachNavigationBar {
        assert(!(base is UINavigationController),
               "UINavigationController can't use this property, please use configuration.")
        return base._navigationBar
    }
    
    var item: UINavigationItem {
        assert(!(base is UINavigationController),
               "UINavigationController can't use this property, please use configuration.")
        return base._navigationItem
    }
}

public extension Navigation where Base: UINavigationController {
    
    var configuration: Configuration {
        return base._configuration
    }
    
    @available(iOS 11.0, *)
    func prefersLargeTitles() {
        guard configuration.isEnabled else { return }
        
        base.navigationBar.prefersLargeTitles = true
    }
}
