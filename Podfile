# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

use_frameworks!

workspace 'UpcomingMovies'
project 'UpcomingMovies.xcodeproj'

target 'UpcomingMovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks

  # Pods for UpcomingMovies
  pod 'SwiftLint'
  pod 'Swinject'
  pod 'Kingfisher'
  pod 'Kingfisher/SwiftUI'
  pod 'CollectionViewSlantedLayout', '~> 3.1'
  pod 'KeychainSwift', '~> 19.0'

  pod 'UpcomingMoviesDomain', :path => 'UpcomingMoviesDomain/'
  
  target 'UpcomingMoviesTodayExtension' do
    pod 'Kingfisher'
  end

  target 'UpcomingMoviesWidgetExtension' do
    pod 'Kingfisher/SwiftUI'
  end

end

target 'NetworkInfrastructure' do
  project 'NetworkInfrastructure/NetworkInfrastructure.xcodeproj'
  pod 'KeychainSwift', '~> 19.0'
end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
