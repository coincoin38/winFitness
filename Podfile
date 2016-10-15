post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

platform :ios, '9.3'

target 'myGymSwift' do
use_frameworks!
pod 'RealmSwift'
pod 'SwiftyJSON'
pod 'FBSDKCoreKit'
pod 'AlamofireImage'
pod 'Alamofire', '~> 4.0'
pod 'APESuperHUD', '~> 1.1'
end