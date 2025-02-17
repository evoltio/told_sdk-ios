#
# Be sure to run `pod lib lint ToldSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Told'
  s.version          = '2.0.0'
  s.summary          = 'Official Told iOS SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Official Told iOS SDK, a new way to collect feedbacks !
                       DESC

  s.homepage         = 'https://github.com/evoltio/told_sdk-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Told' => 'contact@told.club' }
  s.source           = { :git => 'https://github.com/evoltio/told_sdk-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '16.0'

  s.source_files = 'Sources/**/*'
  s.exclude_files = 'Sources/Remote/graphql'

  s.swift_version = '5.9'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'SwiftUI'
  s.dependency 'Apollo', '~> 1.15.3'
end
