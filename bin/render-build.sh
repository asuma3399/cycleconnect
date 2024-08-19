#!/usr/bin/env bash
# exit on error
set -o errexit

export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/lib/pkgconfig"
export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/lib:$LD_LIBRARY_PATH"

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate