# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'fran'
set :repo_url, 'git@example.com:me/my_repo.git'

ask :branch, :master

set :deploy_to, '/opt/fran'
set :scm, :git

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
