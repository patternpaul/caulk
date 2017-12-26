# caulk
When you just want to join some commands together

## What does this give me?
* Easy way to group some commands together
* Formatting to group output to a given command.
* Timings for a given command
* Integrations to CI systems
* Pushes you to group commands into logical things like build or deploy
* Easy way to migrate away

## Quick Start

Add a `Gemfile` to your repository configured with caulk!
``` ruby
source 'http://rubygems.org'

group :development do
  gem "caulk"
end
```

Run `bundle install` to install the gem

Add a `Rakefile` to your repository. 
``` ruby
require 'caulk/tasks'

task :default => [
    'run: echo Hello World!',
    'run: echo Time to glue some steps together with caulk!'
]

```

Run `rake`!

## CONFIGURATIONS
#### Basic Configuration
Each `run: ` line is a shell call you'd like to run as part of your build process. Break out larger "bucket" commands to simplify your CI system

``` ruby
require 'caulk/tasks'

task :build => [
    'run: ./gradlew build -x test',
    'run: ./gradlew test',
]

task :deploy => [
    'run: ./warn_slack_deploy_start.sh',
    'run: ./some_deploy_script.sh',
    'run: ./warn_slack_deploy_end.sh'
]

task :default => [
    :build
]

```
Then use those master alias commands in your CI system: `rake build` or `rake deploy`


#### Jenkins and Phabricator Config (using the [Phabricator Plugin](https://plugins.jenkins.io/phabricator-plugin)) 
Set the environment variable `PHABRICATOR_COMMENT_FILE` to indicate what file it should dump pass/fail status of each step. Configure the Jenkins plugin to consume that same file.

![phab](https://raw.githubusercontent.com/patternpaul/caulk/master/readme/phab.png "phab")

Phabrictor Differentials will get the following output

![phab-output](https://raw.githubusercontent.com/patternpaul/caulk/master/readme/phab-output.png "phab-output")

#### Jenkins and Github Pull Request Config (using the [Github Pull Request Builder Plugin](https://plugins.jenkins.io/ghprb))
Set the environment variable `GITHUB_AUTH_TOKEN` with an auth token that has `repo:status` privileges. Pull request builds will post back step results
![jenkins-output](https://raw.githubusercontent.com/patternpaul/caulk/master/readme/jenkins.png "jenkins-output")

#### Travis CI and Github Pull Request Config
Set the environment variable `GITHUB_AUTH_TOKEN` with an auth token that has `repo:status` privileges. Pull request builds will post back step results
![travis-output](https://raw.githubusercontent.com/patternpaul/caulk/master/readme/travis.png "travis-output")

