execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

require_recipe 'ssmtp'
require_recipe 'delayed_job'
require_recipe 'admin'
