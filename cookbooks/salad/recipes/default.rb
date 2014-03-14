cookbook_file "/tmp/foo.txt" do
  mode 0644
end

# FIXME: when moving this LWRP to the jenkins cookbooks, the name will look better
salad_jenkins_tracking "/tmp/bar.txt"
