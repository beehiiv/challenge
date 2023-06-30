#!/usr/bin/env bash
# exit on error
set -o errexit

bundle config set frozen false

bundle install
# clean
rm -rf public

# build
yarn install

# migrate
bundle exec rake db:migrate

# postbuild
cp -a client/build/. public/