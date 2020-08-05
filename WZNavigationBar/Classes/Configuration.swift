//
//  Configuration.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - Configuration
public final class Configuration {
    
    /// 是否启用
    public var isEnabled = false
    
    /// 是否隐藏
    public var isHidden = false
    
    /// alpha
    public var alpha: CGFloat = 1
    
    /// barTintColor
    public var barTintColor: UIColor?
    
    /// tintColor
    public var tintColor: UIColor?
    
    /// shadowImage
    public var shadowImage: UIImage?
    
    // 是否隐藏ShadowImage
    public var isShadowHidden: Bool = false
    
    /// titleTextAttributes
    public var titleTextAttributes: [NSAttributedString.Key : Any]?
    
    /// isTranslucent(毛玻璃的效果)
    public var isTranslucent: Bool = true
    
    /// barStyle
    public var barStyle: UIBarStyle = .default
    
    /// statusBarStyle
    public var statusBarStyle: UIStatusBarStyle = .default
    
    /// Additional height for the navigation bar.
    public var additionalHeight: CGFloat = 0
    
    @available(iOS 11.0, *)
    /// Padding of navigation bar content view.
    public lazy var layoutPaddings: UIEdgeInsets = {
        Const.NavigationBar.layoutPaddings
    }()
    
    /// shadow
    public var shadow: Shadow?
    
    /// backItem
    public var backItem: BackItem?
    
    /// _largeTitleTextAttributes
    var _largeTitleTextAttributes: [NSAttributedString.Key: Any]?
    
    /// 背景图片
    var backgroundImage: UIImage?
    
    /// barMetrics
    var barMetrics: UIBarMetrics = .default
    
    /// barPosition
    var barPosition: UIBarPosition = .any
}

/// MARK - BackItem
extension Configuration {
    
    public struct BackItem {
        public let style: BackBarButtonItem.ItemStyle
        public let tintColor: UIColor?
        
        public init(style: BackBarButtonItem.ItemStyle, tintColor: UIColor? = nil) {
            self.style = style
            self.tintColor = tintColor
        }
    }
}

/// MARK - largeTitleTextAttributes
extension Configuration {
    
    @available(iOS 11.0, *)
    public var largeTitleTextAttributes: [NSAttributedString.Key: Any]? {
        get { return _largeTitleTextAttributes }
        set { _largeTitleTextAttributes = newValue }
    }
}

/// MARK - func
extension Configuration {
    
    /// 设置背景图片
    /// - Parameters:
    ///   - backgroundImage: 图片
    ///   - barPosition: UIBarPosition
    ///   - barMetrics: UIBarMetrics
    public func setBackgroundImage(
        _ backgroundImage: UIImage?,
        for barPosition: UIBarPosition = .any,
        barMetrics: UIBarMetrics = .default) {
        self.backgroundImage = backgroundImage
        self.barPosition = barPosition
        self.barMetrics = barMetrics
    }
}

