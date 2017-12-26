require 'caulk/tasks'

task :build => [
    'run:rubocop',
    'run:rspec'
]

task :default => [
    :build
]