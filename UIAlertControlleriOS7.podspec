Pod::Spec.new do |s|
  s.name     = 'UIAlertControlleriOS7'
  s.version  = '0.4'
  s.license  = 'MIT'
  s.summary  = 'UIAlertController for iOS7'
  s.homepage = 'https://github.com/andriitishchenko/UIAlertControlleriOS7'
  s.authors  = {
    'Andrii Tishchenko' => 'andrii.tishchenko@gmail.com'
  }
  s.source   = {
    :git => 'https://github.com/andriitishchenko/UIAlertControlleriOS7',
    :tag => s.version.to_s
  }
  s.source_files = 'Source/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '7.1'
end