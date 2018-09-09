# pod lib lint --use-libraries --verbose --allow-warnings
# s.ios.vendored_frameworks = "xxx/**/*.framework"
# s.ios.vendored_libraries = "xxx/**/*.a"
# https://www.cnblogs.com/huntaiji/p/6908982.html

Pod::Spec.new do |s|
  s.name         = "CHBaseUtil"
  s.version      = "1.0.4"
  s.summary      = "CHBaseUtil 封装了一些常用的工具类，！！！ created by 峰云逸飞-李长鸿 ！！！有任何问题请给我留言交流"

  s.description  = <<-DESC
                      CHBaseUtil 封装了一些常用工具类，新创建项目的时候可以直接引用
          CHBaseUtil_UI, 主要是一些常用的UI方面的category。Font Image Label Color View Toast Frame Cell 之类的category方法。 
          CHBaseUtil_VC 是ViewController的一些实用方法的封装，为了今后复用
          ios Router 的实现，比现有已知第三方更简单易用，注册url是在运行时自动注册
          CHBaseUtil_Safe 是数组或字典等的一些实用方法的封装，为了今后复用 
          CHBaseUtil_Util, 主要是开发中常用到的一些小工具，如自定义的UserDefault、FileManager、Digest、Observer、Regex、Singleton 
          CHBaseUtil_JKDBModel_Category.为JKDBModel添加获取行数的方法
          an iOS app runtime debugger, vzinspector & flex 的整合及升级。FLEX ~> 2.4.0  & VZInspector ~> 0.1.3
            1,修改VZInspectorOverlay.m，flex插件加入
            2，加入文件VZCPUInspector VZCPUInspectorOverView 显示cpu读数
                   DESC

  s.homepage     = "https://github.com/lichanghong/CHBaseUtil.git"
  s.license      = "MIT"
  s.author       = { "李长鸿" => "1211054926@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/lichanghong/CHBaseUtil.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.ios.deployment_target = '8.0'



  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.source_files = 'CHBaseUtil.h'
 
  
  s.default_subspecs = 'VC', 'UI', 'Router', 'Safe', 'JKDBModel'

  s.subspec 'UI' do |ui|
    ui.source_files = 'CHBaseUtil_UI/Classes/**/*'
  end
      
  s.subspec 'VC' do |vc|
    vc.source_files = 'CHBaseUtil_VC/Classes/**/*'
  end

  s.subspec 'JKDBModel' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'CHBaseUtil_JKDBModel_Category/Classes/**/*'
    ss.public_header_files = 'CHBaseUtil_JKDBModel_Category/Classes/JKDBModel+JKDBModel.h'
    ss.dependency 'FMDB', '~> 2.7.2'
    ss.libraries     = "sqlite3"
  end

  s.subspec 'Router' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'CHBaseUtil_Router/Classes/**/*'
    ss.ios.frameworks = 'UIKit', 'Foundation'
  end
   
  s.subspec 'Safe' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'CHBaseUtil_Safe/Classes/**/*'
  end

  s.subspec 'Util' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'CHBaseUtil_Util/Classes/**/*'
    ss.library = 'c++'
  end

 s.subspec 'FLEXInspector' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'FLEXInspector/Classes/**/*'
    ss.framework     = 'Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore'
    ss.source_files  = 'FLEXInspector/Classes/**/*.{h,c,m,mm}'
    ss.libraries     = "z", "c++", "sqlite3"
    mrr_files = [
      'FLEXInspector/Classes/toolbox/mermoryProfile/vendor/allocationTrack/NSObject+VZAllocationTracker.mm',
      'FLEXInspector/Classes/toolbox/mermoryProfile/vendor/allocationTrack/VZAllocationTrackerNSZombieSupport.mm',
      'FLEXInspector/Classes/toolbox/mermoryProfile/vendor/Associations/VZAssociationManager.mm',
      'FLEXInspector/Classes/toolbox/mermoryProfile/vendor/Layout/Blocks/VZBlockStrongLayout.m',
      'FLEXInspector/Classes/toolbox/mermoryProfile/vendor/Layout/Blocks/VZBlockStrongRelationDetector.m',
      'FLEXInspector/Classes/toolbox/mermoryProfile/vendor/Layout/Classes/VZClassStrongLayoutHelpers.m'
    ]
    files = Pathname.glob("FLEXInspector/Classes/**/*")
    files = files.map {|file| file.to_path}
    files = files.reject {|file| mrr_files.include?(file)}

    ss.public_header_files = [ "FLEXInspector/Classes/**/*.{h}", "FLEXInspector/Classes/*.{h}" ]

    # 解决 cannot create __weak reference in file using manual reference counting
    ss.xcconfig = {
      'CLANG_ENABLE_OBJC_WEAK' => 'YES'
    }
    ss.requires_arc = files
  end




end
