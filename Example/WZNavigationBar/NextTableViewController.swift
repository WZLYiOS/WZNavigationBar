//
//  NextTableViewController.swift
//  WZNavigationBar_Example
//
//  Created by xiaobin liu on 2019/12/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - 下一页
class NextTableViewController: UITableViewController {

    private lazy var throttler = {
        return Throttler(interval: 0.2)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.item.title = "Demo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        if #available(iOS 11.0, *) {
            navigation.bar.prefersLargeTitles = false
        }
        
        navigation.bar.backBarButtonItem?.shouldBack = { item in
            let alert = UIAlertController(title: "确定退出", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
                item.goBack()
            })
            self.present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    @objc private func backBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}


extension UIColor {
    func isDarkColor() -> Bool {
        var w: CGFloat = 0
        self.getWhite(&w, alpha: nil)
        return w > 0.5 ? false : true
    }
}

/// MARK - scrollViewDelegate
extension NextTableViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - (scrollView.contentOffset.y) / (scrollView.contentSize.height - view.bounds.height)
        //navigation.bar.alpha = alpha
        
        /// 如果是透明度的用这种方式
        if alpha < 0.8 {
            navigation.bar.statusBarStyle = .default
        } else {
            navigation.bar.statusBarStyle = .lightContent
        }
        
        /// 如果背景是张图片的话用这种方式改变状态栏颜色
        //refreshStatusBarStyle()
    }
    
    private func refreshStatusBarStyle() {
        
        calculateStatusBarAreaAvgLuminance { [weak self] avgLuminance in
            guard let self = self else { return }
            let antiFlick: CGFloat = 0.1 / 2
            if avgLuminance <= 0.8 - antiFlick {
                self.navigation.bar.statusBarStyle = .default
            } else if avgLuminance >= 0.8 + antiFlick {
                self.navigation.bar.statusBarStyle = .lightContent
            }
        }
    }
    
    private func getLayer(completion: @escaping (CALayer) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let layer = self?.view.layer else { return }
            completion(layer)
        }
    }
    
    private func calculateStatusBarAreaAvgLuminance(_ completion: @escaping (CGFloat) -> Void) {
        let scale: CGFloat = 0.5
        let size = UIApplication.shared.statusBarFrame.size
        getLayer { [weak self] layer in
            self?.throttler.throttle {
                UIGraphicsBeginImageContextWithOptions(size, false, scale)
                guard let context = UIGraphicsGetCurrentContext() else { return }
                layer.render(in: context)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                guard let averageLuminance = image?.averageLuminance else { return }
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    completion(averageLuminance)
                }
            }
        }
    }
}

private extension UIImage {
    var averageLuminance: CGFloat? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage,
                                                          kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [CIContextOption.workingColorSpace: kCFNull!])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0,
                                      width: 1, height: 1),
                       format: CIFormat.RGBA8,
                       colorSpace: nil)

        let r = CGFloat(bitmap[0]) / 255
        let g = CGFloat(bitmap[1]) / 255
        let b = CGFloat(bitmap[2]) / 255
        // Luminance coeficents taken from https://en.wikipedia.org/wiki/Relative_luminance
        let luminance = 0.212 * r + 0.715 * g + 0.073 * b
        return luminance
    }
}

public class Throttler {

    private let queue = DispatchQueue.global(qos: .background)

    private var job: DispatchWorkItem? {
        didSet {
            oldValue?.cancel()
        }
    }
    private var previousRun: Date?

    var maxInterval: TimeInterval

    init(interval: TimeInterval = 0.3) {
        self.maxInterval = interval
    }

    func throttle(_ actions: @escaping () -> Void) {
        let job = DispatchWorkItem { [weak self] in
            self?.previousRun = Date()
            actions()
        }
        self.job = job
        let delay: TimeInterval
        if let previousRun = previousRun {
            let interval = Date().timeIntervalSince(previousRun)
            delay = interval > maxInterval ? 0 : maxInterval
        } else {
            delay = 0
        }
        queue.asyncAfter(deadline: .now() + delay, execute: job)
    }
}
