# 我主良缘WZNavigationBar

## Requirements:
- **iOS** 9.0+
- Xcode 10.0+
- Swift 5.0+


## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'WZNavigationBar', '~> 0.2.0'</code></pre>

## Use

```swift
  // 全局统一配置:
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.isShadowHidden = true
        nav.navigation.configuration.barTintColor = UIColor.red
        nav.navigation.configuration.tintColor = UIColor.white
        nav.navigation.configuration.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.navigation.configuration.statusBarStyle = .lightContent
        // 是否大标题
        if #available(iOS 11.0, *) {
            nav.navigation.prefersLargeTitles()
        }
        nav.navigation.configuration.backItem = Configuration.BackItem(style: BackBarButtonItem.ItemStyle.image(UIImage(named: "navigation_back_default")))
```

```swift
   // 单个控制器配置
    navigation.bar.isHidden = true
    navigation.bar.statusBarStyle = .default
    if #available(iOS 11.0, *) {
        navigation.bar.prefersLargeTitles = false
   }
```


## License
WZNavigationBar is released under an MIT license. See [LICENSE](LICENSE) for more information.
