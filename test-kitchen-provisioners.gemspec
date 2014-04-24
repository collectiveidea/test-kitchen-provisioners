Gem::Specification.new do |gem|
  gem.name    = "test-kitchen-provisioners"
  gem.version = "0.1"
  gem.license = "MIT"
  gem.authors = ["Collective Idea"]
  gem.email   = ["info@collectiveidea.com"]

  gem.summary     = "A collection of helpful provisioniners for working with Test Kitchen"
  gem.description = gem.summary
  gem.homepage    = "https://github.com/collectiveidea/test-kitchen-provisioners"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{spec})
  gem.require_paths = ["lib"]

  gem.add_dependency "chef",         "~> 11.6.0"
  gem.add_dependency "test-kitchen", "~> 1.2.0"
end
