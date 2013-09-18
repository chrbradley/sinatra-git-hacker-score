require 'sinatra'
require 'sinatra/reloader' if development?
require 'rubygems'
require 'open-uri'
require 'json'
# load 'read_github.rb'

get '/' do 
  # @gituser = "chrbradley"
  erb :index
end

post '/' do
  @gituser = params[:gituser]
  # puts "https://api.github.com/users/#{@gituser}"
  erb :index
end

def score(a,b,c,d)
  a+b+c+d
end
__END__
@@layout
<html>
  <head>
    <title>Github Hacker Score</title>
    <link rel="stylesheet" href="/style.css" type="text/css">
  </head>
  <body>
    <div class="content">
      
      <%= yield %>

    </div>
  </body>
</html>

@@index
<form action="/" class="form-inline" method="POST">
  <input type="text" placeholder="Enter Github User" name="gituser">
  <button type="submit" class="btn">Get it</button>
</form>
<% if @gituser %>
  <% open("https://api.github.com/users/#{@gituser}") do |f| %>
    <% json_string = f.read %>
    <% parsed_json = JSON.parse(json_string) %>
    <% name = parsed_json['name'] %>
    <% public_repos = parsed_json['public_repos'] %>
    <% followers = parsed_json['followers'] %>
    <% following = parsed_json['following'] %>
    <% public_gists = parsed_json['public_gists'] %>
    <p>Name: <%= name || "Name not Public" %></p>
    <p>Public Repositories: <%= public_repos %></p>
    <p>Followers: <%= followers %></p>
    <p>Following: <%= following %></p>
    <p>Public Gists: <%= public_gists %></p>
    <h2> Hacker Score: <%= score(public_repos,public_gists,followers,following) %></h2>
  <% end %>
<% end %>