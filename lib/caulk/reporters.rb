require 'caulk/reporters/out'
require 'caulk/reporters/jenkins_to_phabricator'
require 'caulk/reporters/jenkins_to_github_pr'
require 'caulk/reporters/travis_to_github_pr'

module Reporters
  class << self
    def register(reporter)
      collection << reporter
    end

    def started(message)
      collection.each do |reporter|
        reporter.started(message)
      end
    end

    def success(message, minutes, seconds)
      collection.each do |reporter|
        reporter.success(message, minutes, seconds)
      end
    end

    def failed(message, minutes, seconds)
      collection.each do |reporter|
        reporter.failed(message, minutes, seconds)
      end
    end

    private

    def collection
      @reporters ||= init
    end

    def init
      reporters = []
      reporters << Out.new
      reporters << JenkinsToPhabricator.new(ENV['PHABRICATOR_COMMENT_FILE']) if ENV.key?('PHABRICATOR_COMMENT_FILE')
      reporters << JenkinsToGithubPR.new(ENV['GITHUB_AUTH_TOKEN']) if ENV.key?('GITHUB_AUTH_TOKEN') && ENV.key?('JENKINS_HOME')
      reporters << TravisToGithubPR.new(ENV['GITHUB_AUTH_TOKEN']) if ENV.key?('GITHUB_AUTH_TOKEN') && ENV['TRAVIS_PULL_REQUEST']
      reporters
    end
  end
end
