class Out
  def started(message)
    banner "Started: #{message}"
  end

  def success(message, minutes, seconds)
    banner "Completed: #{message} in #{minutes} minutes and #{seconds} seconds"
    puts ''
    puts ''
    puts ''
    puts ''
    puts ''
  end

  def failed(message, minutes, seconds)
    banner "Failed: #{message} in #{minutes} minutes and #{seconds} seconds"
  end

  private

  def banner(message)
    puts '*--------------------------------------------*'
    puts "* #{message}"
    puts '*--------------------------------------------*'
  end
end
