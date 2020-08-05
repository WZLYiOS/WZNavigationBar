//
//  ViewController.swift
//  WZNavigationBar
//
//  Created by LiuSky on 12/03/2019.
//  Copyright (c) 2019 LiuSky. All rights reserved.
//

import UIKit
import WZNavigationBar


/// MARK - NavigationBarType
public enum NavigationBarType: Int, CustomStringConvertible, CaseIterable {
    
    case navigationBar
    case alpha
    case titleAlpha
    case isShadowHidden
    case extraHeight
    case prefersLargetTitle
    case largeTitleAlpha
    case statusBarStyle
    case statusBarHidden
    case navigation
    
    public var description: String {
        switch self {
        case .navigationBar:
            return "隐藏导航栏"
        case .alpha:
            return "导航栏透明度"
        case .titleAlpha:
            return "标题透明度"
        case .isShadowHidden:
            return "隐藏黑线"
        case .extraHeight:
            return "额外高度"
        case .prefersLargetTitle:
            return "显示大标题"
        case .largeTitleAlpha:
            return "大标题透明度"
        case .statusBarStyle:
            return "状态栏颜色"
        case .statusBarHidden:
            return "隐藏状态栏 (非刘海屏有效)"
        case .navigation:
            return "无导航栏控制器"
        }
    }
}

/// MARK - 演示项目
class ViewController: UIViewController {

    /// 列表
    private lazy var tableView: UITableView = {
        let temTableView = UITableView()
        temTableView.rowHeight = 50
        temTableView.dataSource = self
        temTableView.delegate = self
        temTableView.separatorInset = .zero
        temTableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "SwitchTableViewCell")
        temTableView.register(SliderTableViewCell.self, forCellReuseIdentifier: "SliderTableViewCell")
        temTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        temTableView.tableFooterView = UIView()
        temTableView.translatesAutoresizingMaskIntoConstraints = false
        return temTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private var isStatusBarHidden: Bool = false
    
    /// 配置
    private func config() {
        
        navigation.item.title = "导航栏Demo"
        navigation.item.rightBarButtonItem = UIBarButtonItem(
        title: "Next",
        style: .plain,
        target: self,
        action: #selector(rightBarButtonAction))
        navigation.bar.statusBarStyle = .lightContent
        navigation.bar.shadow = .none
        
        if #available(iOS 11.0, *) {
            navigation.bar.prefersLargeTitles = false
        }
    }
    
    @objc private func rightBarButtonAction() {
        navigationController?.pushViewController(NextTableViewController(style: .plain), animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

/// MARK - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NavigationBarType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = NavigationBarType.allCases[indexPath.row]
        switch model {
        case .navigationBar:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            cell.switch.isOn = navigation.bar.isHidden
            cell.textLabel?.text = model.description
            cell.switch.addTarget(self, action: #selector(isHiddenAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .alpha:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell", for: indexPath) as! SliderTableViewCell
            let model = NavigationBarType.allCases[indexPath.row]
            cell.textLabel?.text = model.description
            cell.slider.value = Float(navigation.bar.alpha)
            cell.slider.addTarget(self, action: #selector(setAlphaAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .titleAlpha:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell", for: indexPath) as! SliderTableViewCell
            let model = NavigationBarType.allCases[indexPath.row]
            cell.textLabel?.text = model.description
            cell.slider.value = 1.0
            cell.slider.addTarget(self, action: #selector(setTitleAlphaAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .isShadowHidden:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            cell.textLabel?.text = model.description
            cell.switch.isOn = navigation.bar.isShadowHidden
            cell.switch.addTarget(self, action: #selector(isShadowHiddenAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .extraHeight:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell", for: indexPath) as! SliderTableViewCell
            let model = NavigationBarType.allCases[indexPath.row]
            cell.textLabel?.text = model.description
            cell.slider.minimumValue = 0
            cell.slider.maximumValue = 20
            cell.slider.value = Float(navigation.bar.additionalHeight)
            cell.slider.addTarget(self, action: #selector(extraHeightAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .prefersLargetTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            cell.textLabel?.text = model.description
            if #available(iOS 11.0, *) {
                cell.switch.isOn = navigation.bar.prefersLargeTitles
            } else {
                cell.switch.isOn = false
            }
            cell.switch.addTarget(self, action: #selector(prefersLargetTitleAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .largeTitleAlpha:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderTableViewCell", for: indexPath) as! SliderTableViewCell
            let model = NavigationBarType.allCases[indexPath.row]
            cell.textLabel?.text = model.description
            cell.slider.value = 1.0
            cell.slider.addTarget(self, action: #selector(setLargeTitleAlphaAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .statusBarStyle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            cell.textLabel?.text = model.description
            cell.switch.isOn = true
            cell.switch.addTarget(self, action: #selector(changeStatusBarStyle(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .statusBarHidden:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            cell.textLabel?.text = model.description
            cell.switch.isOn = isStatusBarHidden
            cell.switch.addTarget(self, action: #selector(isStatusBarHiddenAction(_:)), for: UIControl.Event.valueChanged)
            return cell
        case .navigation:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = model.description
            return cell
        }
    }
    
    @objc private func isHiddenAction(_ sender: UISwitch) {
        navigation.bar.isHidden = sender.isOn
    }
    
    @objc private func setAlphaAction(_ sender: UISlider) {
        navigation.bar.alpha = CGFloat(sender.value)
    }
    
    @objc private func setTitleAlphaAction(_ sender: UISlider) {
        navigation.bar.setTitleAlpha(CGFloat(sender.value))
    }
    
    @objc private func isShadowHiddenAction(_ sender: UISwitch) {
        navigation.bar.isShadowHidden = sender.isOn
    }
    
    @objc private func extraHeightAction(_ sender: UISlider) {
        navigation.bar.additionalHeight = CGFloat(sender.value)
    }
    
    @objc private func prefersLargetTitleAction(_ sender: UISwitch) {
        if #available(iOS 11.0, *) {
            navigation.bar.prefersLargeTitles = sender.isOn
        }
    }
    
    @objc private func setLargeTitleAlphaAction(_ sender: UISlider) {
        if #available(iOS 11.0, *) {
            navigation.bar.setLargeTitleAlpha(CGFloat(sender.value))
        }
    }
    
    @objc private func changeStatusBarStyle(_ sender: UISwitch) {
        navigation.bar.statusBarStyle = sender.isOn ? .lightContent : .default
    }
    
    @objc private func isStatusBarHiddenAction(_ sender: UISwitch) {
        isStatusBarHidden = sender.isOn
        setNeedsStatusBarAppearanceUpdate()
    }
}

/// MARK - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == NavigationBarType.navigation.rawValue {
            let vc = NoNavigationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


/// MARK - SwitchTableViewCell
final class SwitchTableViewCell: UITableViewCell {
    
    /// 开关
    public var `switch`: UISwitch = {
        let temSwitch = UISwitch()
        return temSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryView = self.switch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// MARK - SliderTableViewCell
final class SliderTableViewCell: UITableViewCell {
    
    /// slider
    public var slider: UISlider = {
        let temSwitch = UISlider()
        return temSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryView = self.slider
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
