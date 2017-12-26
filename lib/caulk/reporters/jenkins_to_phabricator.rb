
class JenkinsToPhabricator
  def initialize(phab_file)
    @phab_file = phab_file
  end

  def started(message) end

  def success(message, minutes, seconds)
    log "> Passed: #{message} (#{minutes} minutes #{seconds} seconds)"
  end

  def failed(message, minutes, seconds)
    log "```COUNTEREXAMPLE
Failed: #{message} (#{minutes} minutes #{seconds} seconds)```"
  end

  private

  def log(message)
    File.open(@phab_file, 'a+') do |file|
      file.puts(message)
    end
  end
end
