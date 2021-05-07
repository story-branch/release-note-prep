#!/bin/sh -l

echo '::group:: Installing github_api gem'
gem install -N github_api
echo '::endgroup::'

export CHANGELOG_GITHUB_TOKEN="${INPUT_GITHUB_TOKEN}"
echo '::group:: Running script'
ruby /release_notes.rb
echo '::endgroup::'
