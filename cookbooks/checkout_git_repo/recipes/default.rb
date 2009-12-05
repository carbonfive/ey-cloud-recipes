#
# Cookbook Name:: checkout_git_repo
# Recipe:: default
#
if ['solo', 'app', 'app_master'].include?(node[:instance_role])

  bash "pull git repo" do
    code "cd /content.bedsider/bedsider-content && git pull"
  end
end
