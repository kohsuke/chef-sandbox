cookbook_path Dir.pwd+"/cookbooks"
role_path Dir.pwd+"/roles"
data_bag_path Dir.pwd+"/databags"

# install custom handler
# this code can live in client.rb, too
# TODO: if I need to configure which HTTP URL to send the report to, how should I do that?
require 'cookbooks/salad/libraries/myhandler'
report_handlers << MyHandler.new( :abc => 1, :def => 2)

#require 'chef/handler/json_file.rb'
#report_handlers << Chef::Handler::JsonFile.new
