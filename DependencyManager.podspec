
Pod::Spec.new do |s|
  s.name             = 'DependencyManager'
  s.version          = '1.0.0'
  s.summary          = 'Simple DependencyManager.'
  s.swift_version    = '4.2'
  s.description      = <<-DESC
DependencyManager provides simple way to manage dependencies accors app,
Initialise it on demand in release if when no longer needed.
                       DESC

  s.homepage         = 'https://github.com/Michael-Vorontsov/DependencyManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michael Vorontsov' => 'michel06@ukr.net' }
  s.source           = { :git => 'https://github.com/Michael-Vorontsov/DependencyManager.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'DependencyManager/Classes/**/*'
  
end
