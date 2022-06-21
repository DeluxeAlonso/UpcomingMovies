
Pod::Spec.new do |spec|

  spec.name = "UpcomingMoviesDomain"
  spec.version = "0.0.1"
  spec.summary = "Domain layer"

  spec.description = "Domain layer intended to be used by upcoming movies app."
  spec.homepage = "https://github.com/DeluxeAlonso/UpcomingMovies"

  spec.license = "MIT"

  spec.authors = { "DeluxeAlonso" => "alonso.alvarez.dev@gmail.com" }
  spec.social_media_url = "https://github.com/DeluxeAlonso"

  spec.ios.deployment_target = "12.0"

  spec.source = { :git => "http://DeluxeAlonso/UpcomingMoviesDomain.git", :tag => "#{spec.version}" }
  spec.source_files  = "UpcomingMoviesDomain"
  spec.public_header_files = "UpcomingMoviesDomain/**/*.h"

  spec.default_subspec = 'Core'

  spec.subspec "Core" do |subspec|
    subspec.source_files = "UpcomingMoviesDomain/Core", "UpcomingMoviesDomain/Core/**/*.{swift}"
  end

  spec.subspec "TestDoubles" do |subspec|
    subspec.source_files = "UpcomingMoviesDomain/TestDoubles", "UpcomingMoviesDomain/TestDoubles/**/*.{swift}"
  end

  spec.test_spec 'UpcomingMoviesDomainTests' do |test_spec|
    test_spec.source_files = 'UpcomingMoviesDomainTests/*.{swift}', 'UpcomingMoviesDomainTests/**/*.{swift}'
  end

end

