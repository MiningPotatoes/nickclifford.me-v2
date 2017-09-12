require "kemal"
require "./handlers/sass_handler"

def partial(id : Symbol, title : String)
  # TODO
end

get "/" do
  partial :index, "Home"
end

Kemal.run
