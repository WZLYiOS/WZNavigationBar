//
//  UIViewController+Load.m
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WZNavigationBar/WZNavigationBar-Swift.h>

@implementation UIViewController (Load)

+ (void)load {
    [UIViewController navigation_methodSwizzling];
}

@end
