#
# Cookbook Name:: admin
# Recipe:: default
#

# what info is provided in the node? lets find out.
if ['solo', 'app_master'].include?(node[:instance_role])

  file "/data/config/admin.out" do
    owner "root"
    group "root"
    mode 0644
    action :create
    content node.to_yaml.to_s
  end

end
