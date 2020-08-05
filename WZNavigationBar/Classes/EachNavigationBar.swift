//
//  EachNavigationBar.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - EachNavigationBar
open class EachNavigationBar: UINavigationBar {
    
    /// 自动调整位置时，视图布局
    open var automaticallyAdjustsPosition: Bool = true
    
    /// 额外添加的高度
    open var additionalHeight: CGFloat = 0 {
        didSet {
            frame.size.height = barHeight + _additionalHeight
            viewController?.adjustsSafeAreaInsetsAfterIOS11()
        }
    }
    
    /// 是否先死ShadowImage
    open var isShadowHidden: Bool = false {
        didSet {
            guard let background = subviews.first else { return }
            background.clipsToBounds = isShadowHidden
        }
    }
    
    /// 状态栏风格
    open var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            superNavigationBar?.barStyle = _barStyle
        }
    }
    
    /// 后退按钮项
    open var backBarButtonItem: BackBarButtonItem? {
        didSet {
            backBarButtonItem?.navigationController = viewController?.navigationController
            
            viewController?._navigationItem.leftBarButtonItem = backBarButtonItem
        }
    }

    @available(iOS 11.0, *)
    /// 导航栏内容视图的填充
    public lazy var layoutPaddings: UIEdgeInsets = {
        Const.NavigationBar.layoutPaddings
    }()
    
    /// 额外视图
    open var additionalView: UIView? {
        didSet {
            guard let additionalView = additionalView else {
                oldValue?.removeFromSuperview()
                return
            }
            
            setupAdditionalView(additionalView)
        }
    }
    
    /// 阴影
    open var shadow: Shadow = .none {
        didSet { layer.apply(shadow) }
    }
    
    /// 内容视图
    private var _contentView: UIView?
    
    /// alpha
    var _alpha: CGFloat = 1
    
    /// 控制器
    weak var viewController: UIViewController?
    
    /// 初始化
    /// - Parameter viewController: 控制器
    public convenience init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
        setItems([viewController._navigationItem], animated: false)
    }
    
    
    /// 布局子视图
    open override func layoutSubviews() {
        super.layoutSubviews()
        _layoutSubviews()
    }
}

/// MARK - 高度
extension EachNavigationBar {
    
    var _barStyle: UIBarStyle {
        return statusBarStyle == .default ? .default : .black
    }
    
    var _additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if prefersLargeTitles { return 0 }
        }
        return additionalHeight
    }
    
    private var barHeight: CGFloat {
        if let bar = superNavigationBar {
            return bar.frame.height
        } else {
            return Const.NavigationBar.height
        }
    }
}

/// MARK -
extension EachNavigationBar {
    
    private var superNavigationBar: UINavigationBar? {
        return viewController?.navigationController?.navigationBar
    }
    
    @available(iOS 11.0, *)
    private var contentView: UIView? {
        if let contentView = _contentView { return contentView }
        
        let className: String
        if #available(iOS 13.0, *) {
            className = "UINavigationBarContentView"
        } else {
            className = "_UINavigationBarContentView"
        }
        _contentView = subviews.filter { String(describing: $0.classForCoder) == className }.first
        
        return _contentView
    }
    
    private func setupAdditionalView(_ additionalView: UIView) {
        addSubview(additionalView)
        additionalView.translatesAutoresizingMaskIntoConstraints = false
        additionalView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        additionalView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        additionalView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        additionalView.heightAnchor.constraint(
            equalToConstant: additionalView.frame.height).isActive = true
    }
}

/// MARk - 
extension EachNavigationBar {
    
    func adjustsLayout() {
        guard let navigationBar = viewController?.navigationController?.navigationBar else { return }
        
        if automaticallyAdjustsPosition {
            frame = navigationBar.frame
            if #available(iOS 11.0, *) {
                if prefersLargeTitles {
                    frame.origin.y = Const.StatusBar.maxY
                }
            }
        } else {
            frame.size = navigationBar.frame.size
        }
        
        frame.size.height = navigationBar.frame.height + _additionalHeight
    }
    
    private func _layoutSubviews() {
        guard let background = subviews.first else { return }
        background.alpha = _alpha
        background.clipsToBounds = isShadowHidden
        background.frame = CGRect(
            x: 0,
            y: -Const.StatusBar.maxY,
            width: bounds.width,
            height: bounds.height + Const.StatusBar.maxY)
        
        adjustsLayoutMarginsAfterIOS11()
    }
    
    private func adjustsLayoutMarginsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        
        layoutMargins = Const.NavigationBar.layoutMargins
        contentView?.frame.origin.y = prefersLargeTitles ? 0 : additionalHeight
        contentView?.layoutMargins = layoutPaddings
    }
}

