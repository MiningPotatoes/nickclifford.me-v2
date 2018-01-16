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

get "/advisory" do
  advisees = %w(Hanna Ben Eli Gini Hadley Nick Palmer Sameer Sloane Skyler)

  days = JSON.parse(File.read("./public/misc/days.json")).as_h.each_with_object({} of Time => Int32) do |(year, v0), memo|
    v0.as(Hash(String, JSON::Type)).each do |(month, v1)|
      v1.as(Hash(String, JSON::Type)).each do |(day, v2)|
        cycle_day = JSON::Any.new(v2).as_i
        memo[Time.new(year.to_i, month.to_i, day.to_i)] = cycle_day unless cycle_day == 1 || cycle_day == 4
      end
    end
  end

  day_pairs = days.each.zip(advisees.cycle).reject {|(d, _)| d[0] < Time.now.at_end_of_day}

  partial :advisory, "Advisory Snack"
end

Kemal.run 3692
