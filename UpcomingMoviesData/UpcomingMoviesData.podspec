
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

  spec.source_files  = "UpcomingMoviesData"
  spec.public_header_files = "UpcomingMoviesData/**/*.h"

  spec.default_subspec = 'Core'

  spec.subspec "Core" do |subspec|
    subspec.source_files = "UpcomingMoviesData/Core", "UpcomingMoviesData/Core/**/*.{swift}"
  end

  spec.subspec "TestDoubles" do |subspec|
    subspec.source_files = "UpcomingMoviesData/TestDoubles", "UpcomingMoviesData/TestDoubles/**/*.{swift}"
  end

  spec.dependency "UpcomingMoviesDomain"
  spec.dependency "UpcomingMoviesDomain/TestDoubles"

  spec.test_spec 'UpcomingMoviesDataTests' do |test_spec|
    test_spec.source_files = 'UpcomingMoviesDataTests/*.{swift}', 'UpcomingMoviesDataTests/**/*.{swift}'
  end

end
