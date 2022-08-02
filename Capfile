# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

require 'capistrano/postgresql'
require 'capistrano/cookbook'

require 'sshkit/sudo'

require 'capistrano/puma'
install_plugin Capistrano::Puma # Default puma tasks
install_plugin Capistrano::Puma::Workers # if you want to control the workers (in cluster mode)
# install_plugin Capistrano::Puma::Jungle # if you need the jungle tasks
install_plugin Capistrano::Puma::Monit # if you need the monit tasks
install_plugin Capistrano::Puma::Nginx # if you want to upload a nginx site template
install_plugin Capistrano::Puma::Systemd, load_hooks: false # if you use SystemD

require 'capistrano/sidekiq'
install_plugin Capistrano::Sidekiq # Default sidekiq tasks
# Then select your service manager
install_plugin Capistrano::Sidekiq::Systemd

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
