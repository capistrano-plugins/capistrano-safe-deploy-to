namespace :load do
  task :defaults do
    set :safe_deploy_to_owner, nil
    set :safe_deploy_to_path, -> { fetch(:deploy_to) }
  end
end

namespace :safe_deploy_to do
  task :create do
    on roles :all do
      sudo :mkdir, '-pv', fetch(:safe_deploy_to_path)
    end
  end

  task ensure_owner: [:create] do
    on roles :all do
      unless fetch(:safe_deploy_to_owner)
        user = capture :id, '-un'
        group = capture :id, '-gn'
        set :safe_deploy_to_owner, "#{user}:#{group}"
      end
      sudo :chown, fetch(:safe_deploy_to_owner), fetch(:safe_deploy_to_path)
    end
  end

  desc "Ensures deploy_to directory exists and has the right owner"
  task ensure: [:create, :ensure_owner]
end

before "deploy:check", "safe_deploy_to:ensure"
before "setup", "safe_deploy_to:ensure" if Rake::Task.task_defined?(:setup)
