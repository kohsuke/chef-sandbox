Gem::Specification.new do |g|
  g.name = 'chef-handler-jenkins'
  g.version = '0.1'

  g.description = 'Chef report handler for tracking with Jenkins'
  g.summary = g.description

  g.require_paths = ['lib']
  g.files = `git ls-files`.split($\)

  g.add_dependency 'chef', '>=11.6'
end