#
# Cookbook Name:: paperclip
# Recipe:: default
#
node[:applications].each do |app_name, data|

  template "/data/config/paperclip.yml" do
    source "paperclip.yml.erb"
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    variables({
            :access_key_id => node[:aws_secret_id],
            :secret_access_key => node[:aws_secret_key]
    })
  end

end