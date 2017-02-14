require 'haml'
require 'sass/plugin/rack'
require 'sinatra/base'

class NickCliffordV2 < Sinatra::Base
  configure do
    use Sass::Plugin::Rack
  end

  get '/' do
    haml :index, locals: {
      title: 'Home'
    }
  end
end