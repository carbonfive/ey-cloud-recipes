#
# Cookbook Name:: google_analytics
# Recipe:: default
#
if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  node[:applications].each do |app_name, data|
    link "setup-google_analytics.yml-symlink" do
      to '/data/config/google_analytics.yml'
      target_file "/data/#{app_name}/current/config/google_analytics.yml"
    end
  end
end