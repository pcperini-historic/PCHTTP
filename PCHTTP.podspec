Pod::Spec.new do |s|

  s.name         = "PCHTTP"
  s.version      = "1.0.1"
  s.summary      = "PCHTTP - A Simple Cocoa HTTP Client"

  s.homepage     = "https://github.com/pcperini/PCHTTP"
  # s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"

  s.license      = { :type => 'CCA', :file => 'LICENSE.md' }

  s.authors          = {
      "Patrick Perini" => "pcperini@gmail.com",
      "Jim Cervone" => "jimcervone@gmail.com"
  }
  # s.author           = 'Patrick Perini', 'other author'
  # s.social_media_url = "http://twitter.com/Patrick Perini"

  s.ios.deployment_target = '4.0'
  s.osx.deployment_target = '10.6'

  s.source       = {
      :git => "https://github.com/pcperini/PCHTTP.git",
      :tag => "v1.0.1"
  }

  s.source_files  = 'PCHTTP/*.{h,m}'
  s.requires_arc = true

end
