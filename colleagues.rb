require "sinatra/base"
require "slack"
require "sanitize"

class App < Sinatra::Base
  set :bind, ENV['BIND'] || 'localhost'

  Slack.configure do |config|
    config.token = ENV["SLACK_TOKEN"]
  end

  get "/" do
    client = Slack::Web::Client.new
    @members = client.users_list.members.select { |m| m.is_bot == false && m.id != "USLACKBOT" && m.deleted == false }
    haml :index
  end
end

App.run!
