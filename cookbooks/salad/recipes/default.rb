cookbook_file "/tmp/foo.txt" do
  mode 0644
end

# FIXME: when moving this LWRP to the jenkins cookbooks, the name will look better
salad_jenkins_tracking "/tmp/bar.txt"

# TODO: is this another way to install a handler?
# chef_gem 'chef-handler-jenkins'  or something like that
#include_recipe 'chef_handler'
#chef_handler "Jenkins::TrackingHandler" do
#  # source ""
#end

chef_gem 'chef-handler-jenkins'

chef_handler 'Chef::Handler::Jenkins' do
  source 'chef/handler/jenkins'
  arguments :url => 'http://localhost:8080/jenkins'
  action :enable
end