
Pod::Spec.new do |s|
  s.name             = 'DependencyManager'
  s.version          = '0.1.0'
  s.summary          = 'Simple DependencyManager.'
  s.swift_version    = '4.2'
  s.description      = <<-DESC
DependencyManager provides simple way to manage dependencies accors app,
Initialise it on demand in release if when no longer needed.
                       DESC

  s.homepage         = 'https://github.com/Michael-Vorontsov/DependencyManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michael Vorontsov' => 'mykhailov@starsgroup.com' }
  s.source           = { :git => 'https://github.com/Michael Vorontsov/DependencyManager.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'DependencyManager/Classes/**/*'
  
end
