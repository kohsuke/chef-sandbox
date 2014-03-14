#!/bin/bash
sudo rm /tmp/foo.txt
exec sudo chef-solo -j node.json -c solo.rb