#
# Be sure to run `pod lib lint APExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'APExtensions'
  s.version          = '3.4.8'
  s.summary          = 'A helpful collection of extensions, controllers and protocols.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A helpful collection of extensions, controllers and protocols. See documentation for details.
                       DESC

  s.homepage         = 'https://github.com/APUtils/APExtensions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anton Plebanovich' => 'anton.plebanovich@gmail.com' }
  s.source           = { :git => 'https://github.com/APUtils/APExtensions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'APExtensions/Classes/**/*'
  
  # s.resource_bundles = {
  #   'APExtensions' => ['APExtensions/Assets/*.png']
  # }

  s.private_header_files = 'APExtensions/Classes/_Extensions/Swizzling/SwizzlingLoader.h'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit', 'MessageUI'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.subspec 'ViewState' do |viewState|
    viewState.source_files = 'APExtensions/Classes/_Extensions/Swizzling/**/*'
    viewState.private_header_files = 'APExtensions/Classes/_Extensions/Swizzling/SwizzlingLoader.h'
  end

  s.subspec 'Storyboard' do |storyboard|
    storyboard.source_files = 'APExtensions/Classes/_Extensions/Storyboard/**/*'
    storyboard.dependency 'APExtensions/ViewState', '>= 3.3.1'
  end
end
