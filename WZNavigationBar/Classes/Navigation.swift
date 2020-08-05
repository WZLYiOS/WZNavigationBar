//
//  Navigation.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - Navigation 命名空间
public struct Navigation<Base> {
    
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

public protocol NavigationCompatible {
    
    associatedtype CompatibleType
    
    var navigation: CompatibleType { get }
}

public extension NavigationCompatible {
    
    var navigation: Navigation<Self> {
        return Navigation(self)
    }
}

extension UIViewController: NavigationCompatible {}
