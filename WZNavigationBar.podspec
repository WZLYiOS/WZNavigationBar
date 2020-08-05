Pod::Spec.new do |s|
  s.name             = 'WZNavigationBar'
  s.version          = '0.2.0'
  s.summary          = 'A custom navigation bar of UIViewController '
  s.homepage         = 'https://github.com/WZLYiOS/WZNavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiuSky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/WZNavigationBar.git', :tag => s.version.to_s }
 

  s.requires_arc = true
  s.static_framework = true
  s.swift_version         = '5.0'
  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Source'
  
  s.subspec 'Source' do |ss|
    ss.source_files = 'WZNavigationBar/Classes/**/*'
    ss.resource_bundles = { 'WZNavigationBar' => ['WZNavigationBar/Assets/*.xcassets'] }
  end


  s.subspec 'Binary' do |ss|
    ss.vendored_frameworks = "Carthage/Build/iOS/Static/WZNavigationBar.framework"
    ss.resource_bundles    = { 'WZNavigationBar' => ['WZNavigationBar/Assets/*.xcassets'] }
  end
end
