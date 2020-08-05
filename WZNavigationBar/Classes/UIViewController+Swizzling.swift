//
//  UIViewController+Swizzling.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


infix operator <=>

extension UIViewController {
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public static func navigation_methodSwizzling() {
        methodSwizzling
    }
    
    static let methodSwizzling: Void = {
        #selector(viewDidLoad) <=> #selector(navigation_viewDidLoad)
        #selector(viewWillAppear(_:)) <=> #selector(navigation_viewWillAppear(_:))
        #selector(setNeedsStatusBarAppearanceUpdate)
            <=> #selector(navigation_setNeedsStatusBarAppearanceUpdate)
        #selector(viewDidLayoutSubviews) <=> #selector(navigation_viewDidLayoutSubviews)
    }()
    
    private var isNavigationBarEnabled: Bool {
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled,
            navigationController.viewControllers.contains(self) else { return false }
        return true
    }
    
    @objc private func navigation_viewDidLoad() {
        navigation_viewDidLoad()
        
        guard isNavigationBarEnabled else { return }
        
        setupNavigationBarWhenViewDidLoad()
        
        if let tableViewController = self as? UITableViewController {
            tableViewController.observeContentOffset()
        }
    }
    
    @objc private func navigation_viewWillAppear(_ animated: Bool) {
        navigation_viewWillAppear(animated)
        
        guard isNavigationBarEnabled else { return }
        
        updateNavigationBarWhenViewWillAppear()
    }
    
    @objc private func navigation_setNeedsStatusBarAppearanceUpdate() {
        navigation_setNeedsStatusBarAppearanceUpdate()
        
        adjustsNavigationBarLayout()
    }
    
    @objc private func navigation_viewDidLayoutSubviews() {
        navigation_viewDidLayoutSubviews()
        
        view.bringSubviewToFront(_navigationBar)
    }
}

private extension Selector {
    
    static func <=> (left: Selector, right: Selector) {
        if let originalMethod = class_getInstanceMethod(UIViewController.self, left),
            let swizzledMethod = class_getInstanceMethod(UIViewController.self, right) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

