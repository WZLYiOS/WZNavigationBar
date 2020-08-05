//
//  NoNavigationViewController.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/12/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class NoNavigationViewController: UIViewController {

    /// 跳转
    private lazy var button: UIButton = {
        let temButton = UIButton(type: .custom)
        temButton.backgroundColor = UIColor.red
        temButton.setTitle("跳转", for: UIControl.State.normal)
        temButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        temButton.bounds = CGRect(x: 0, y: 0, width: 100, height: 44)
        temButton.center = self.view.center
        temButton.addTarget(self, action: #selector(pushViewC), for: UIControl.Event.touchUpInside)
        return temButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.item.title = "无导航栏控制器"
        navigation.bar.isHidden = true
        navigation.bar.statusBarStyle = .default
        view.backgroundColor = UIColor.yellow
        view.addSubview(button)
    }
    
    @objc private func pushViewC() {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

