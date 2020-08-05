//
//  BackBarButtonItem.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - 后退按钮Item
open class BackBarButtonItem: UIBarButtonItem {
    
    /// shouldBack
    public var shouldBack: (BackBarButtonItem) -> Bool = { _ in true }
    
    /// 将要后退
    public var willBack: () -> Void = {}
    
    /// 已经后退
    public var didBack: () -> Void = {}
    
    /// 导航栏
    weak var navigationController: UINavigationController?
}

/// MARK - convenience init
public extension BackBarButtonItem {
    
    convenience init(style: ItemStyle, tintColor: UIColor? = nil) {
        let action = #selector(backBarButtonItemAction)
        
        switch style {
        case .title(let title):
            self.init(title: title, style: .plain, target: nil, action: action)
            
            self.target = self
            self.tintColor = tintColor
        case .image(let image):
            self.init(image: image, style: .plain, target: nil, action: action)
            
            self.target = self
            self.tintColor = tintColor
        case .custom(let button):
            self.init(customView: button)
            
            button.addTarget(self, action: action, for: .touchUpInside)
            button.tintColor = tintColor
        }
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

/// MARK - enum
extension BackBarButtonItem {
    
    /// Item样式
    public enum ItemStyle {
        
        /// 标题
        case title(String?)
        
        /// 图标
        case image(UIImage?)
        
        /// 自定义按钮
        case custom(UIButton)
    }
}

/// MARK - private event
extension BackBarButtonItem {
    
    /// 后退事件
    @objc private func backBarButtonItemAction() {
        
        guard shouldBack(self) else { return }
        
        willBack()
        goBack()
        didBack()
    }
}
