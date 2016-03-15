Gem::Specification.new do |s|
  s.name = 'beetrackapi'
  s.version = '0.6.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Nicolás Kipreos', 'Jose Luis Honorato']
  s.email = ['nicolas.kipreos@beetrack.com']
  s.homepage = 'https://github.com/Beetrack/beetrack-api-ruby'
  s.description = 'A Ruby Wrapper for the Beetrack API'
  s.summary = 'See description'
  s.files = Dir.glob('{lib}/**/*') + %w(README.md beetrackapi.gemspec)
  s.add_development_dependency('rest-client', '>= 1.7.3')
  s.require_path = 'lib'
end
