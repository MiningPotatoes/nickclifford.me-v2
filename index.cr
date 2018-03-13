require "http/client"
require "json"
require "kemal"
require "kilt/slang"
require "yaml"
require "./handlers/sass_handler"

macro partial(id, title)
  config_path = "./config/{{id.id}}.yaml"
  config = YAML.parse(
    begin
      File.read(config_path)
    rescue
      ""
    end
  )

  id = {{id.stringify}}
  title = {{title}}
  stylesheet = %{<link href="/css/{{id.id}}.css" rel="stylesheet">} if File.exists?("./scss/{{id.id}}.scss")

  # TODO: fix Slang to allow unescaped interpolation
  HTML.unescape(render "./views/{{id.id}}.slang", "./views/layout.slang")
end

get "/" do
  partial :index, "Home"
end

Kemal.run 3692
