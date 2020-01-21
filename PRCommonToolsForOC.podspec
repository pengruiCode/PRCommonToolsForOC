Pod::Spec.new do |s|

  s.name         = "PRCommonToolsForOC"
  s.version      = "0.0.1"
  s.summary  	 = '适用于OC项目的通用快捷方法'
  s.homepage     = "https://github.com/pengruiCode/PRCommonToolsForOC.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = {'pengrui' => 'pengruiCode@163.com'}
  s.source       = { :git => 'https://github.com/pengruiCode/PRCommonToolsForOC.git', :tag => s.version}
  s.platform 	 = :ios, "11.0"
  s.source_files = "PRCommonToolsForOC/**/*.{h,m}"
  s.resource     = 'PRCommonToolsForOC/**/*.{png,xib}'
  s.requires_arc = true
  s.description  = <<-DESC
			适用于OC项目的通用快捷方法
                   DESC

 end