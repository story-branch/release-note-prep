#!/bin/sh -l

echo '::group:: Installing github_api gem'
gem install -N github_api
echo '::endgroup::'

echo '::group:: Running script'
RELEASE_NOTES=$(ruby /release_notes.rb)
echo "RELEASE_NOTES<<EOF" >> $GITHUBENV
          echo "$RELEASE_NOTES" >> $GITHUBENV
          echo "EOF" >> $GITHUBENV
echo "::set-output name=changelog::$(RELEASE_NOTES)"
echo '::endgroup::'
