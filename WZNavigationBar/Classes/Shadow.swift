//
//  Shadow.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - Shadow
public struct Shadow {
    
    let color: CGColor?
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
    let path: CGPath?
    
    public static let none: Shadow = .init()
    
    public init(color: CGColor? = nil,
                opacity: Float = 0,
                offset: CGSize = CGSize(width: 0, height: -3),
                radius: CGFloat = 3,
                path: CGPath? = nil) {
        self.color = color
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
        self.path = path
    }
}

/// MARK - CALayer
extension CALayer {
    
    func apply(_ shadow: Shadow) {
        shadowColor = shadow.color
        shadowOpacity = shadow.opacity
        shadowOffset = shadow.offset
        shadowRadius = shadow.radius
        shadowPath = shadow.path
    }
}
