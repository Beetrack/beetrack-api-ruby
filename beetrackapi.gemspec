Gem::Specification.new do |s|
  s.name = 'beetrackapi'
  s.version = '0.5.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Nicolás Kipreos']
  s.email = ['nicolas.kipreos@beetrack.com']
  s.homepage = 'http://github.com/nkipreos/'
  s.description = 'A Ruby Wrapper for the Beetrack API'
  s.summary = 'See description'
  s.files = Dir.glob('{lib}/**/*') + %w(README.md beetrackapi.gemspec)
  s.add_development_dependency('rest-client', '>= 1.7.3')
  s.require_path = 'lib'
end
