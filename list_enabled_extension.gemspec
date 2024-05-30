# list-enabled-extensions.gemspec
Gem::Specification.new do |spec|
  spec.name          = 'list_enabled_extensions'
  spec.version       = '0.1.0'
  spec.authors       = ['GPT-4', 'Anton Topchii']
  spec.email         = %w[player1@infinitevoid.net]

  spec.summary       = 'A tool to list enabled VSCode extensions for a workspace'
  spec.description   = <<~DESC
    This search for corresponding workspace in the VSCode `workspaceStorage` directory and lists the enabled extensions.

  DESC

  spec.spec.homepage = 'http://github.com/crawler/list_enabled_extensions'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb', 'exe/*', 'test/**/*', 'README.md', 'LICENSE', '.gitignore']
  spec.bindir        = 'exe'
  spec.executables   = %w[list-enabled-extensions list_enabled_extensions]
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.1.0'

  spec.add_development_dependency 'bundler', '~> 2.5.11'
  # spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency 'minitest', '~> 5.23.1'
  spec.add_development_dependency 'standardrb', '~>1.0.1'

  spec.add_runtime_dependency 'sqlite3', '~> 1.4'
end
