# frozen_string_literal: true

require 'github_api'

token = ENV['CHANGELOG_GITHUB_TOKEN']

github = Github.new(oauth_token: token, user: 'rpbaltazar', repo: 'release-note-prep')
prs = github.pull_requests.list(state: 'closed', sort: 'updated', direction: 'desc')

last_release_index = prs.to_a.index do |pr|
  /Release/i =~ pr[:title]
end

prs_for_release_notes = prs[0...last_release_index].reject do |pr|
  pr.merged_at.nil?
end

puts 'Enhancements'
puts 'Fixes'
puts 'Internal Changes'
prs_for_release_notes.each do |pr|
  puts "* #{pr[:title]} ##{pr[:number]}"
end
