require 'net/http'
require 'json'

class JenkinsToGithubPR
  def initialize(auth_token)
    @auth_token = auth_token
  end

  def started(task)
    return unless pr?

    create_status(task, 'pending', 'started')
  end

  def success(task, _minutes, _seconds)
    return unless pr?
    create_status(task, 'success', 'success!')
  end

  def failed(task, _minutes, _seconds)
    return unless pr?
    create_status(task, 'failure', 'failed :(')
  end

  private

  def create_status(task, state, description)
    status = {
      state: state,
      target_url: build_url,
      description: description,
      context: "jenkins/#{task}"
    }

    uri = URI "https://api.github.com/repos/#{repo}/statuses/#{commit}"
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.add_field('Authorization', "token #{@auth_token}")
    req.body = status.to_json
    Net::HTTP.start(uri.host, 443, use_ssl: true) do |http|
      http.request(req)
    end
  rescue Exception => e # rubocop:disable Lint/RescueException
    puts "Creating Status Failed: #{e}"
  end

  def repo
    ENV['ghprbGhRepository']
  end

  def commit
    ENV['ghprbActualCommit']
  end

  def pr?
    ENV.key?('ghprbActualCommit')
  end

  def build_url
    ENV['BUILD_URL']
  end
end
