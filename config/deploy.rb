# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "harvest"
set :repo_url, "git@github.com:dawidof/harvest.git"
set :deploy_user, 'dawidof'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/home/dawidof/simple_notes'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

set :deploy_to, "/home/#{fetch(:deploy_user)}/#{fetch(:full_app_name)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/master.key', 'config/credentials/production.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
       '.bundle', 'public/system', 'public/uploads', 'storage'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :rvm_type, :auto

set :rvm_ruby_version, 'ruby-3.1.2'
set :branch, 'main'
set :format, :pretty

# set :puma_user, fetch(:user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))

set :puma_preload_app, false
set :puma_init_active_record, true
set :puma_workers, 3
set :puma_systemctl_user, fetch(:deploy_user)
set :puma_enable_lingering, true

set :sidekiq_systemctl_user, fetch(:deploy_user)
set :sidekiq_enable_lingering, true

set :pg_ask_for_password, true
set :pg_extensions, %w[citext hstore]
set :pg_encoding, 'UTF-8'
set :pg_database, 'harvest_production'
set :pg_username, 'harvest'

set :nginx_config_name, fetch(:application)
set :nginx_sites_available_path, '/home/dawidof/nginx/conf.d'
set :nginx_sites_enabled_path, '/home/dawidof/nginx/enabled'
set :puma_monit_conf_dir, '/etc/monit.d/'
# set :certbot_enable, false
set :nginx_logs_folder, '/home/dawidof/nginx/harvest'

set(:executable_config_files, [])

set(
  :symlinks,
  [
    {
      source: 'nginx.conf',
      link: '/home/dawidof/nginx/conf.d/{{full_app_name}}'
    },
    {
      source: 'log_rotation',
      link: '/etc/logrotate.d/{{full_app_name}}'
    } # ,
    # {
    #   source: 'monit',
    #   link: '/etc/monit/conf.d/{{full_app_name}}.conf'
    # }
  ]
)

set(:config_files,
    [{
      source: File.join(File.expand_path(__dir__), 'database.yml'),
      # source: 'database.yml',
      destination: "#{shared_path}/config/database.yml",
      executable: false,
      as_root: false
    },
     {
       source: 'nginx_conf',
       destination: "/home/dawidof/nginx/conf.d/#{fetch(:application)}.conf",
       executable: false,
       as_root: true
     },
     {
       source: File.join(File.expand_path(__dir__), 'credentials', 'production.key'),
       # source: 'database.yml',
       destination: "#{shared_path}/config/credentials/production.key",
       executable: false,
       as_root: false
     }])
puts deploy_path.inspect
puts shared_path.inspect
puts fetch(:deploy_to).inspect
puts Pathname.new(fetch(:deploy_to)).inspect

# puts "db: #{ENV['SIMPLE_NOTES_DATABASE_PASSWORD'].inspect}"
