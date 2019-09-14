Pod::Spec.new do |s|
s.name         = "CGXVerticalMenuView-OC"    #存储库名称
s.version      = "0.2"      #版本号，与tag值一致
s.summary      = "a CGXVerticalMenuView-OC 菜单封装"  #简介
s.description  = "所有主流APP分类切换滚动视图  封装"  #描述
s.homepage     = "https://github.com/974794055/CGXVerticalMenuView-OC"      #项目主页，不是git地址
s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
s.author             = { "974794055" => "974794055@qq.com" }  #作者
s.platform     = :ios, "8.0"                  #支持的平台和版本号
s.source       = { :git => "https://github.com/974794055/CGXVerticalMenuView-OC.git", :tag => s.version }         #存储库的git地址，以及tag值
s.requires_arc = true #是否支持ARC
s.frameworks = 'UIKit'

#需要托管的源代码路径
s.source_files = "CGXVerticalMenuView","CGXVerticalMenuView/**/*.{h,m}"
 

s.subspec "TitleView" do |ss|

end

s.subspec "Comond" do |ss|

end

s.subspec "BaseView" do |ss|


end

s.subspec "IndicatorView" do |ss|

end

end




