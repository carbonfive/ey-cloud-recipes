#
# Cookbook Name:: delayed_job
# Recipe:: default
#

node[:applications].each do |app_name, data|
  user = node[:users].first

  case node[:instance_role]
    when "solo", "app", "app_master"

      worker_name = "job_runner" #safer to make this "#{app_name}_job_runner" if the environment might run multiple apps using delayed_job

      # The symlink is created in /data/app_name/current/tmp/pids -> /data/app_name/shared/pids, but shared/pids doesn't seem to be?
      directory "/data/#{app_name}/shared/pids" do
        owner node[:owner_name]
        group node[:owner_name]
        mode 0755
      end

      template "/etc/monit.d/delayed_job_worker.#{app_name}.monitrc" do
        source "delayed_job_worker.monitrc.erb"
        owner user[:username]
        group user[:username]
        mode 0644
        variables({
                :app_name => app_name,
                :user => node[:owner_name],
                :worker_name => worker_name,
                :framework_env => node[:environment][:framework_env]
        })
      end

    # Reload monit to pick up configuration changes
    bash "monit-reload-restart" do
      user "root"
      code "monit reload && monit"

      #kill all workers to remove any orphaned workers caused when monit spawns extra processes
      #see https://cloud-support.engineyard.com/discussions/problems/415-monit-restart-doesnt-operate-reliably
      code "pidof #{worker_name} | xargs --no-run-if-empty kill"
      #were the above not a concern we could simply restart the job runner in the new environment
      #code "monit restart #{worker_name}"

    end
  end
end