#!/bin/bash
sudo rm /tmp/foo.txt 2>&1 > /dev/null
date > /tmp/bar.txt
exec sudo bundle exec chef-solo -j node.json -c solo.rb