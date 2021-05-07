#!/bin/sh -l

echo '::group:: Installing github_api gem'
gem install -N github_api
echo '::endgroup::'

echo '::group:: Running script'
RELEASE_NOTES=$(ruby /release_notes.rb)
echo "::set-output name=changelog::$(RELEASE_NOTES)"

echo "RELEASE_NOTES<<EOF" >> $GITHUB_ENV
          echo "$RELEASE_NOTES" >> $GITHUB_ENV
          echo "EOF" >> $GITHUB_ENV
echo '::endgroup::'
