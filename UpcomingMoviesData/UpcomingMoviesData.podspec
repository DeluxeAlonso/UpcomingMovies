
Pod::Spec.new do |spec|

  spec.name = "UpcomingMoviesData"
  spec.version = "0.0.1"
  spec.summary = "Domain layer"

  spec.description = "Data layer intended to work as a data source for upcoming movies app"
  spec.homepage = "https://github.com/DeluxeAlonso/UpcomingMovies"

  spec.license = "MIT"

  spec.authors = { "DeluxeAlonso" => "alonso.alvarez.dev@gmail.com" }
  spec.social_media_url = "https://github.com/DeluxeAlonso"

  spec.ios.deployment_target = "12.0"

  spec.source = { :git => "http://DeluxeAlonso/UpcomingMoviesData.git", :tag => "#{spec.version}" }
  spec.source_files  = "UpcomingMoviesData", "UpcomingMoviesData/**/*.{swift}"
  spec.public_header_files = "UpcomingMoviesData/**/*.h"

  spec.dependency "UpcomingMoviesDomain"

  spec.test_spec 'UpcomingMoviesDataTests' do |test_spec|
    test_spec.source_files = 'UpcomingMoviesDataTests/*.{swift}'
  end

end
