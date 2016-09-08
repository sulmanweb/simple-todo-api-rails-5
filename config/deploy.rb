# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'todo_api'
set :repo_url, 'git@github.com:sulmanweb/simple-todo-api-rails-5.git'

set :deploy_to, '/home/deploy/todo_api'

set :keep_releases, 3
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :bundle_binstubs, nil

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rails, "db:seed"
        end
      end
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
