lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caulk/version'

Gem::Specification.new do |gem|
  gem.name          = 'caulk'
  gem.version       = File.exist?('VERSION') ? File.read('VERSION').strip : ''
  gem.authors       = ['Paul Everton']
  gem.email         = ['pattern.paul@gmail.com']
  gem.description   = 'When you just want to join some commands together'
  gem.summary       = 'When you just want to join some commands together'
  gem.homepage      = 'https://github.com/patternpaul/caulk'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f =~ /^docs/ }
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
