# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'UpcomingMovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UpcomingMovies
  pod 'SwiftLint'
  pod 'Swinject'
  pod 'Kingfisher', '5.13.4'
  pod 'CollectionViewSlantedLayout', '~> 3.1'
  
  target 'NetworkInfrastructure' do
    use_frameworks!
    pod 'KeychainSwift', '~> 19.0'
    inherit! :search_paths
  end
  
  target 'UpcomingMoviesWidget' do
     use_frameworks!
     pod 'Kingfisher', '5.13.4'
  end

  target 'UpcomingMoviesTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |pi|
      pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end
  end

end
