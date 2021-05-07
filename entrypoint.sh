#!/bin/sh -l

echo '::group:: Installing github_api gem'
gem install -N github_api
echo '::endgroup::'

echo '::group:: Running script'
echo "::set-output name=changelog::$(ruby /release_notes.rb)"
echo '::endgroup::'
