require 'spec_helper'
require 'rake'
require 'caulk/tasks/run'
require 'caulk/reporters/out'


describe 'run:' do
  let(:shell_command) { 'echo stuff > /dev/null' }
  let(:reports_spy) { spy('Reporters') }
  before do
    stub_const('Reporters', reports_spy)
  end

  let :run_rake_task do
    Rake::Task["run: #{shell_command}"].reenable
    Rake.application.invoke_task "run: #{shell_command}"
  end

  it 'will make the call' do
    run_rake_task

    expect(reports_spy).to have_received(:started).with(shell_command)
    expect(reports_spy).to have_received(:success)
  end
end
