# frozen_string_literal: true

require 'github_api'

token = ENV['CHANGELOG_GITHUB_TOKEN']
full_repo = ENV['GITHUB_REPO']
user, repo = full_repo.split('/')

github = Github.new(oauth_token: token, user: user, repo: repo)
prs = github.pull_requests.list(state: 'closed', sort: 'updated', direction: 'desc')

last_release_index = prs.to_a.index do |pr|
  /Release/i =~ pr[:title]
end

prs_for_release_notes = if last_release_index.zero?
                          prs.to_a
                        else
                          prs[0...last_release_index]
                        end

prs_for_release_notes = prs_for_release_notes.reject do |pr|
  pr.merged_at.nil?
end

puts 'Enhancements'
puts 'Fixes'
puts 'Internal Changes'
prs_for_release_notes.each do |pr|
  puts "* #{pr[:title]} ##{pr[:number]}"
end
