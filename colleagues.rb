require 'sinatra/base'
require "slack"

class App < Sinatra::Base
  Slack.configure do |config|
    config.token = ENV["SLACK_TOKEN"]
  end

  get '/' do
    client = Slack::Web::Client.new
    @members = client.users_list.members
    haml :index
  end
end

App.run!
