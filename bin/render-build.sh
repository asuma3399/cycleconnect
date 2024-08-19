#!/usr/bin/env bash
# exit on error
set -o errexit

# OpenSSLのライブラリパスを設定
export LD_LIBRARY_PATH=/home/linuxbrew/.linuxbrew/Cellar/openssl@3/3.3.1/lib:$LD_LIBRARY_PATH

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate