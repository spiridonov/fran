# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'fran'
set :repo_url, 'git@github.com:spiridonov/fran.git'

set :branch, :master

set :deploy_to, '/opt/fran'
set :scm, :git

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

namespace :unicorn do
  task :restart do
    on roles(:web) do
      execute "sudo service unicorn restart"
    end
  end
end

after 'deploy:finished', 'unicorn:restart'