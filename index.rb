require 'haml'
require 'yaml'
require 'sass/plugin/rack'
require 'sinatra/base'
require 'sinatra/reloader'

class NickCliffordV2 < Sinatra::Base
  configure do
    register Sinatra::Reloader

    require_relative 'lib/babel'

    Sass::Plugin.options[:sourcemap] = :none
    Sass::Plugin.options[:unix_newlines] = true
    use Sass::Plugin::Rack
    use Babel
  end

  helpers do
    def partial(id, title)
      locals = {id: id, title: title}

      locals[:script] =
        if File.exist?(File.expand_path("./public/javascripts/es6/#{id}.es6", __dir__))
          "<script src='/javascripts/#{id}.js'></script>"
        else
          nil
        end

      locals[:stylesheet] =
        if File.exist?(File.expand_path("./public/stylesheets/sass/#{id}.scss", __dir__))
          "<link href='/stylesheets/#{id}.css' rel='stylesheet'>"
        else
          nil
        end

      config_path = File.expand_path("./config/#{id}.yaml", __dir__)
      config = 
        if File.exist?(config_path)
          YAML.load_file(config_path)
        else
          {}
        end

      haml(id, locals: locals.merge(config))
    end
  end

  get '/' do
    partial :index, 'Home'
  end
end
