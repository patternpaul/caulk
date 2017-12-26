require 'caulk/taskblock'

namespace 'caulk' do
  rule(/^run:/) do |task|
    task_string = task.to_s.dup.sub!('run:', '').strip

    TaskBlock.track task_string do
      sh task_string
    end
  end
end
