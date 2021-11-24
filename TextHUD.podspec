
Pod::Spec.new do |spec|

  spec.name         = "TextHUD"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of TextHUD."

  spec.description  = <<-DESC
		A short description of TextHUD InWindow or InView .
                   DESC

  spec.homepage     = "https://github.com/MrLuanJX/TextHUD.git"

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "MrLuanJX" => "22392372@qq.com" }

 spec.platform     = :ios, "9.0"

  spec.source       = { :git => "https://github.com/MrLuanJX/TextHUD.git", :tag => "#{spec.version}" }


  spec.source_files  = "TextHUD/TextHUD/**/*.{h,m}"

  spec.dependency "Masonry", "~> 1.1.0"

end
