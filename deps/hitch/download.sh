#!/bin/sh
curl -L https://github.com/varnish/hitch/archive/master.tar.gz | tar xz
cd hitch-master*
./bootstrap
./configure