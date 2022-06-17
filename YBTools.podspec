Pod::Spec.new do |s|
  s.name         = "YBTools" # 项目名称
  s.version      = "1.0.0"        # 版本号 与 你仓库的 标签号 对应
  s.license      = "MIT"   # 开源证书
  s.summary      = "常用的一些工具类" # 项目简介

  s.homepage     = "https://gitee.com/XinDeGangWan/YBTools" # 你的主页
  s.source       = { :git => "https://gitee.com/XinDeGangWan/YBTools.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址

  s.source_files  = 'YBTools/Classes/**/*.{h,m}'
// Classes下不包含任何内容时，以下代码要注释或者直接删除
# s.source_files = 'YBTools/Classes/**/*.{h,m}'
// 不包含任何bundle资源时，以下代码要注释或者直接删除
# s.resource_bundles = {
#   'YBTools' => ['YBTools/Assets/*.png']
# }

  #s.requires_arc = true # 是否启用ARC
  s.platform     = :ios, "10.0" #平台及支持的最低版本
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  
  # User
  s.author             = { "LinYongbin" => "447000693@qq.com" } # 作者信息

end