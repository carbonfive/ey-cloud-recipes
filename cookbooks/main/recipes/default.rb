execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

require_recipe 'paperclip'
require_recipe 'google_analytics'
require_recipe 'ssmtp'
require_recipe 'delayed_job'
