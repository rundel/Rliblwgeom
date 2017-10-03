#!/bin/sh

cp ../Version.config ./
cp ../postgis_svn_revision.h ./
  
grep -rl postgis_config.h ./ | xargs sed -i '' 's@../postgis_config.h@postgis_config_stub.h@g'
grep -rl postgis_svn_revision.h ./ | xargs sed -i '' 's@../postgis_svn_revision.h@postgis_svn_revision.h@g'
