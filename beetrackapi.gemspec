Gem::Specification.new do |s|
  s.name = 'beetrackapi'
  s.version = '0.3.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Nicolás Kipreos']
  s.email = ['nicolas.kipreos@beetrack.in']
  s.homepage = 'http://github.com/nkipreos/'
  s.description = 'A Ruby Wrapper for the Beetrack API'
  s.summary = 'See description'
  s.files = Dir.glob('{lib}/**/*') + %w(README.md beetrackapi.gemspec)
  s.add_development_dependency('curb', '>= 0.8.5')
  s.require_path = 'lib'
end
