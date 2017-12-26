require 'caulk/reporters'

module TaskBlock
  def self.track(message, &code)
    start_time = Time.now
    Reporters.started message

    begin
      code.call
    rescue Exception => e # rubocop:disable Lint/RescueException
      end_time = Time.now
      minutes, seconds = (end_time - start_time).divmod(60)
      Reporters.failed(message, minutes, seconds)
      puts e
      exit(1)
    end

    end_time = Time.now
    minutes, seconds = (end_time - start_time).divmod(60)
    Reporters.success(message, minutes, seconds)
  end
end
