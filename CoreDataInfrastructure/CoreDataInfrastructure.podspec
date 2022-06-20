
Pod::Spec.new do |spec|

  spec.name = "CoreDataInfrastructure"
  spec.version = "0.0.1"
  spec.summary = "Core data infraestructure layer"

  spec.description = "Core data infraestructure layer intended to be used by upcoming movies app data layer."
  spec.homepage = "https://github.com/DeluxeAlonso/UpcomingMovies"

  spec.license = "MIT"

  spec.authors = { "DeluxeAlonso" => "alonso.alvarez.dev@gmail.com" }
  spec.social_media_url = "https://github.com/DeluxeAlonso"

  spec.ios.deployment_target = "12.0"

  spec.source = { :git => "http://DeluxeAlonso/CoreDataInfrastructure.git", :tag => "#{spec.version}" }
  spec.source_files  = "CoreDataInfrastructure", "CoreDataInfrastructure/**/*.{swift}"
  spec.public_header_files = "CoreDataInfrastructure/**/*.h"

  spec.resources = "CoreDataInfrastructure/*.xcdatamodeld"

  spec.dependency "UpcomingMoviesDomain"
  spec.dependency "UpcomingMoviesData"

  spec.test_spec 'CoreDataInfrastructureTests' do |test_spec|
    test_spec.source_files = 'CoreDataInfrastructureTests/*.{swift}', 'CoreDataInfrastructureTests/**/*.{swift}'
  end

end
