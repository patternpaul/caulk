require 'caulk/reporters/jenkins_to_github_pr'
require 'spec_helper'

# rubocop:disable Metrics/LineLength
describe JenkinsToGithubPR do
  subject { JenkinsToGithubPR.new('SOME_AUTH_TOKEN') }
  let(:task) { 'some_task' }
  let(:minutes) { 1 }
  let(:seconds) { 30 }
  let(:repo) { 'owner/repo'}
  let(:githash) { 'bb90fbf0d19bed137b7866300a7314fa7ecce5b8' }
  let(:jenkins_build_url) { 'https://jenkins.test/job/some_job_name/1/' }

  it 'will track started' do
    VCR.use_cassette 'github_create_status' do
      subject.started task
    end
  end
end

