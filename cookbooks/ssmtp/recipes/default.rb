#
# Cookbook Name:: ssmtp
# Recipe:: default
#
if ['solo', 'app', 'app_master', 'util'].include?(node[:instance_role])
    link "setup-ssmtp.conf-symlink" do
      to '/data/config/ssmtp.conf'
      target_file '/etc/ssmtp/ssmtp.conf'
    end
    execute "set ssmtp.conf permissions" do
      owner = node[:owner_name]
      command "chown #{owner}:#{owner} /etc/ssmtp/ssmtp.conf"
      action :run
    end
end