#!/bin/bash
sudo rm /tmp/foo.txt
echo testing LWRP > /tmp/bar.txt
exec sudo chef-solo -j node.json -c solo.rb