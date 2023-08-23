# This file is used by Rack-based servers to start the application.

require "rack/cors"
require_relative "config/environment"

Rails.application.load_server

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ENV["USERNAME"] && password == ENV["PASSWORD"]
end

app = Rack::Builder.new {
  use Rack::Static,
    urls: ["/static", "/robots.txt"],
    root: "client/build",
    index: "index.html"

  run lambda { |_env|
    [
      200,
      {
        "Content-Type" => "text/html"
      },
      File.open("client/build/index.html", File::RDONLY)
    ]
  }
}

run Rack::URLMap.new(
  "/" => app,
  "/api" => Rails.application
)
