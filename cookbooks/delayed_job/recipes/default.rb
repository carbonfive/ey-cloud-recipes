#
# Cookbook Name:: delayed_job
# Recipe:: default
#

# instance role names come from engineyard convention

# util machine is the only guy who will run the delayed jobs
if ['app', 'app_master','util'].include?(node[:instance_role])
  node[:applications].each do |app_name,data|
  
    #Always set our worker count to 2
    worker_count = 2
    
    worker_count.times do |count|
      template "/etc/monit.d/delayed_job#{count+1}.#{app_name}.monitrc" do
        source "dj.monitrc.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
          :app_name => app_name,
          :user => node[:owner_name],
          :worker_name => "delayed_job#{count+1}",
          :framework_env => node[:environment][:framework_env]
        })
      end
    end
    
    execute "monit-reload-restart" do
       command "sleep 30 && monit quit"
       action :run
    end
      
  end
end
