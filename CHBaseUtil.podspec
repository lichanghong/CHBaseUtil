# pod lib lint --use-libraries --verbose --allow-warnings
Pod::Spec.new do |s|
  s.name         = "CHBaseUtil"
  s.version      = "0.0.9"
  s.summary      = "CHBaseUtil 封装了一些常用的工具类，！！！ created by 峰云逸飞-李长鸿 ！！！有任何问题请给我留言交流"

  s.description  = <<-DESC
                      CHBaseUtil 封装了一些常用工具类，新创建项目的时候可以直接引用
          CHBaseUtil_UI, 主要是一些常用的UI方面的category。Font Image Label Color View Toast Frame Cell 之类的category方法。 
          CHBaseUtil_VC 是ViewController的一些实用方法的封装，为了今后复用
          ios Router 的实现，比现有已知第三方更简单易用，注册url是在运行时自动注册
          CHBaseUtil_Safe 是数组或字典等的一些实用方法的封装，为了今后复用 
          CHBaseUtil_Util, 主要是开发中常用到的一些小工具，如自定义的UserDefault、FileManager、Digest、Observer、Regex、Singleton 
          CHBaseUtil_JKDBModel_Category.为JKDBModel添加获取行数的方法

                   DESC

  s.homepage     = "https://github.com/lichanghong/CHBaseUtil.git"
  s.license      = "MIT"
  s.author             = { "李长鸿" => "1211054926@qq.com" }
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


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.


  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  s.default_subspecs = 'VC', 'UI', 'Router', 'Safe' 

  s.subspec 'UI' do |ui|
    ui.source_files = 'CHBaseUtil_UI/Classes/**/*'
  end
      
  s.subspec 'VC' do |vc|
    vc.source_files = 'CHBaseUtil_VC/Classes/**/*'
  end

  s.subspec 'Router' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'CHBaseUtil_Router/Classes/**/*'
    ss.ios.frameworks = 'UIKit', 'Foundation'
  end
   
  s.subspec 'Safe' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'CHBaseUtil_Safe/Classes/**/*'
    ss.public_header_files = 'CHBaseUtil_Safe/Classes/CHBaseUtil_Safe.h'
  end

  # s.subspec 'Util' do |ss|
  #   ss.ios.deployment_target = '8.0'
  #   ss.source_files = 'CHBaseUtil_Util/Classes/**/*'
  #   ss.public_header_files = 'CHBaseUtil_Util/Classes/CHBaseUtil_Util.h'
  #   ss.dependency 'CHBaseUtil_Util/CHBaseUtil_Safe'
  # end

  # s.subspec 'JKDBModel' do |ss|
  #   ss.ios.deployment_target = '8.0'
  #   ss.source_files = 'CHBaseUtil_JKDBModel_Category/Classes/**/*'
  #   ss.public_header_files = 'CHBaseUtil_JKDBModel_Category/Classes/JKDBModel+JKDBModel.h'
  #   ss.dependency 'FMDB', '~> 2.7.2'
  #   ss.libraries     = "sqlite3"
  # end




end
