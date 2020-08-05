//
//  UIViewController+EachNavigationBar.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/11/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - UIViewController
public extension UIViewController {
    
    func adjustsNavigationBarLayout() {
        _navigationBar.adjustsLayout()
        _navigationBar.setNeedsLayout()
    }
}

/// MARK - UIViewController+EachNavigationBar
extension UIViewController {

    func setupNavigationBarWhenViewDidLoad() {
        guard let navigationController = navigationController else { return }
        
        navigationController.sendNavigationBarToBack()
        view.addSubview(_navigationBar)
        
        if #available(iOS 11.0, *) {
            _navigationBar.prefersLargeTitles = navigationController.navigationBar.prefersLargeTitles
        }
        
        _navigationBar.apply(navigationController._configuration)
        
        let viewControllers = navigationController.viewControllers
        
        guard viewControllers.count > 1 else { return }
        
        guard let backItem = navigationController._configuration.backItem else {
            _navigationBar.backBarButtonItem = buildBackBarButtonItem(viewControllers)
            return
        }
        
        _navigationBar.backBarButtonItem = BackBarButtonItem(style: backItem.style, tintColor: backItem.tintColor)
    }
    
    func updateNavigationBarWhenViewWillAppear() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barStyle = _navigationBar._barStyle
        navigationBar.isHidden = _navigationBar.isHidden
        if #available(iOS 11.0, *) {
            adjustsSafeAreaInsetsAfterIOS11()
            navigationItem.title = _navigationItem.title
            navigationBar.largeTitleTextAttributes = _navigationBar.largeTitleTextAttributes
        }
        view.bringSubviewToFront(_navigationBar)
    }
    
    func adjustsSafeAreaInsetsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        
        let height = _navigationBar.additionalView?.frame.height ?? 0
        additionalSafeAreaInsets.top = _navigationBar.isHidden
            ? -view.safeAreaInsets.top
            : _navigationBar._additionalHeight + height
    }
}

private extension UIViewController {
    
    func buildBackBarButtonItem(_ viewControllers: [UIViewController]) -> BackBarButtonItem {
        let count = viewControllers.count
        
        let backButton = UIButton(type: .system)
        let image = UIImage(named: "navigation_back_default", in: Bundle.current, compatibleWith: nil)
        backButton.setImage(image, for: .normal)
        
        if let title = viewControllers[count - 2]._navigationItem.title {
            let maxWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 3
            let width = (title as NSString).boundingRect(
                with: CGSize(width: maxWidth, height: 20),
                options: NSStringDrawingOptions.usesFontLeading,
                attributes: [.font: UIFont.boldSystemFont(ofSize: 17)],
                context: nil).size.width
            backButton.setTitle(width < maxWidth ? title : "Back", for: .normal)
        } else {
            backButton.setTitle("Back", for: .normal)
        }
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        backButton.contentEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
        backButton.sizeToFit()
    
        return BackBarButtonItem(style: .custom(backButton))
    }
}

private extension EachNavigationBar {
    
    func apply(_ configuration: Configuration) {
        isHidden = configuration.isHidden
        alpha = configuration.alpha
        isTranslucent = configuration.isTranslucent
        barTintColor = configuration.barTintColor
        tintColor = configuration.tintColor
        
        titleTextAttributes = configuration.titleTextAttributes
        shadowImage = configuration.shadowImage
        setBackgroundImage(
            configuration.backgroundImage,
            for: configuration.barPosition,
            barMetrics: configuration.barMetrics)
        
        barStyle = configuration.barStyle
        statusBarStyle = configuration.statusBarStyle
        
        additionalHeight = configuration.additionalHeight
        
        isShadowHidden = configuration.isShadowHidden
        
        if let shadow = configuration.shadow {
            self.shadow = shadow
        }
        
        if #available(iOS 11.0, *) {
            layoutPaddings = configuration.layoutPaddings
            largeTitleTextAttributes = configuration.largeTitleTextAttributes
        }
    }
}

private extension Bundle {
    
    static var current: Bundle? {
        guard let resourcePath = Bundle(for: EachNavigationBar.self).resourcePath,
            let bundle = Bundle(path: "\(resourcePath)/WZNavigationBar.bundle")
        else {
            return nil
        }
        return bundle
    }
}

