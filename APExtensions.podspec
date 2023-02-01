#
# Be sure to run `pod lib lint APExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'APExtensions'
  s.version          = '12.0.0'
  s.summary          = 'A helpful collection of extensions, controllers and protocols.'

  s.description      = <<-DESC
A helpful collection of extensions, controllers and protocols. See documentation for details.
                       DESC

  s.homepage         = 'https://github.com/APUtils/APExtensions'
  s.documentation_url = 'https://aputils.github.io/APExtensions/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anton Plebanovich' => 'anton.plebanovich@gmail.com' }
  s.source           = { :git => 'https://github.com/APUtils/APExtensions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5.5', '5.5.1', '5.5.2', '5.6', '5.6.1', '5.7']
  s.frameworks = 'Foundation'
  
  s.default_subspec = 'Core', 'ViewModel', 'Storyboard'

  s.subspec 'Core' do |subspec|
      subspec.frameworks = 'Foundation', 'UIKit', 'MessageUI'
      subspec.source_files = 'APExtensions/Classes/Core/**/*', 'APExtensions/Classes/Shared/**/*'
      subspec.dependency 'RoutableLogger'
  end

  s.subspec 'ViewModel' do |subspec|
      subspec.frameworks = 'Foundation', 'UIKit'
      subspec.source_files = 'APExtensions/Classes/ViewModel/**/*'
  end

  s.subspec 'Storyboard' do |subspec|
      subspec.frameworks = 'Foundation', 'UIKit'
      subspec.source_files = 'APExtensions/Classes/Storyboard/**/*', 'APExtensions/Classes/Shared/**/*'
      subspec.dependency 'RoutableLogger'
  end
  
  # Extractions
  
  s.subspec 'Occupiable' do |subspec|
      subspec.ios.deployment_target = '11.0'
      subspec.osx.deployment_target = '10.13'
      subspec.watchos.deployment_target = '4.0'
      subspec.tvos.deployment_target = '11.0'
      
      subspec.source_files = 'APExtensions/Classes/Core/_Protocols/Occupiable.swift'
  end
  
  s.subspec 'OptionalType' do |subspec|
      subspec.ios.deployment_target = '11.0'
      subspec.osx.deployment_target = '10.13'
      subspec.watchos.deployment_target = '4.0'
      subspec.tvos.deployment_target = '11.0'
      
      subspec.source_files = 'APExtensions/Classes/Core/_Protocols/OptionalType.swift'
  end
end
