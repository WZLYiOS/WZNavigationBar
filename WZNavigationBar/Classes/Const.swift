//
//  Const.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - 常量
internal struct Const {
    
    /// 状态栏
    struct StatusBar {
        
        static var maxY: CGFloat {
            return UIApplication.shared.statusBarFrame.maxY
        }
    }
    
    
    /// 导航栏Bar
    struct NavigationBar {
        
        /// 高度
        static let height: CGFloat = 44.0
        
        /// layoutPaddings
        static let layoutPaddings: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        /// layoutMargins
        static let layoutMargins: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    }
}
