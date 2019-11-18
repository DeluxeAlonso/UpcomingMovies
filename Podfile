# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'UpcomingMovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UpcomingMovies
  pod 'Kingfisher', '5.3.0'
  pod 'CollectionViewSlantedLayout', '~> 3.1'
  pod 'KeychainSwift', '~> 14.0'
  
  target 'NetworkInfrastructure' do
    use_frameworks!
    pod 'KeychainSwift', '~> 14.0'
    inherit! :search_paths
  end

  target 'UpcomingMoviesTests' do
    inherit! :search_paths
    # Pods for testing
  end

end


