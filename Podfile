deployment_target = '12.0'

platform :ios, deployment_target

target 'UpcomingMovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UpcomingMovies
  pod 'SwiftLint'
  pod 'Swinject'
  pod 'Kingfisher'
  pod 'Kingfisher/SwiftUI'
  pod 'CollectionViewSlantedLayout', '~> 3.1'

  pod 'UpcomingMoviesDomain', :path => 'UpcomingMoviesDomain/', :testspecs => ['UpcomingMoviesDomainTests']
  pod 'UpcomingMoviesData', :path => 'UpcomingMoviesData/', :testspecs => ['UpcomingMoviesDataTests']
  pod 'CoreDataInfrastructure', :path => 'CoreDataInfrastructure/', :testspecs => ['CoreDataInfrastructureTests']
  pod 'NetworkInfrastructure', :path => 'NetworkInfrastructure/', :testspecs => ['NetworkInfrastructureTests']
  
  target 'UpcomingMoviesTodayExtension' do
    pod 'Kingfisher'
    pod 'CoreDataInfrastructure', :path => 'CoreDataInfrastructure/'
  end

  target 'UpcomingMoviesWidgetExtension' do
    pod 'Kingfisher/SwiftUI'
  end

  target 'UpcomingMoviesTests' do
    inherit! :search_paths
  end

  post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
      end
    end
  end

end
