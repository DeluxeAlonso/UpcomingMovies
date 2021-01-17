
Pod::Spec.new do |spec|

  spec.name = "NetworkInfrastructure"
  spec.version = "0.0.1"
  spec.summary = "Domain layer"

  spec.description = "Data layer intended to work as a data source for upcoming movies app"
  spec.homepage = "https://github.com/DeluxeAlonso/UpcomingMovies"

  spec.license = "MIT"

  spec.authors = { "DeluxeAlonso" => "alonso.alvarez.dev@gmail.com" }
  spec.social_media_url = "https://github.com/DeluxeAlonso"

  spec.ios.deployment_target = "12.0"

  spec.source = { :git => "http://DeluxeAlonso/NetworkInfrastructure.git", :tag => "#{spec.version}" }
  spec.source_files  = "NetworkInfrastructure", "NetworkInfrastructure/**/*.{swift}"
  spec.public_header_files = "NetworkInfrastructure/**/*.h"

  spec.resources = "NetworkInfrastructure/BaseParameters.plist"

  spec.dependency "UpcomingMoviesDomain"
  spec.dependency "UpcomingMoviesData"
  spec.dependency "KeychainSwift", "~> 19.0"

  spec.test_spec 'NetworkInfrastructureTests' do |test_spec|
    test_spec.source_files = 'NetworkInfrastructureTests/*.{swift}'
  end

end
