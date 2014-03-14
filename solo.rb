cookbook_path Dir.pwd+"/cookbooks"
role_path Dir.pwd+"/roles"


# install custom handler
# this code can live in client.rb, too
# TODO: if I need to configure which HTTP URL to send the report to, how should I do that?
require 'lib/myhandler'
report_handlers << MyHandler.new

require 'chef/handler/json_file.rb'
report_handlers << Chef::Handler::JsonFile.new
