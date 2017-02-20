require 'haml'
require 'yaml'
require 'sass/plugin/rack'
require 'sinatra/base'
require 'sinatra/reloader'

class NickCliffordV2 < Sinatra::Base
  configure do
    register Sinatra::Reloader

    require_relative 'lib/babel'

    if settings.environment == 'production'
      Sass::Plugin.options[:sourcemap] = :none
      Babel.sourcemaps = false
    end

    Sass::Plugin.options[:template_location] = './src/sass'
    Sass::Plugin.options[:unix_newlines] = true
    use Sass::Plugin::Rack
    use Babel
  end

  helpers do
    def partial(id, title, locals = {})
      locals[:id] = id
      locals[:title] = title
      locals[:script] =
        if File.exist?(File.expand_path("./src/es6/#{id}.es6", __dir__))
          "<script src='/javascripts/#{id}.js'></script>"
        end
      locals[:stylesheet] =
        if File.exist?(File.expand_path("./src/sass/#{id}.scss", __dir__))
          "<link href='/stylesheets/#{id}.css' rel='stylesheet'>"
        end

      config_path = File.expand_path("./config/#{id}.yaml", __dir__)
      locals.merge!(YAML.load_file(config_path)) if File.exist?(config_path)

      haml(id, locals: locals)
    end
  end

  get '/' do
    partial :index, 'Home'
  end
end
