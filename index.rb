require 'haml'
require 'yaml'
require 'sass/plugin/rack'
require 'sinatra/base'
require 'sinatra/reloader'

class NickCliffordV2 < Sinatra::Base
  configure do
    register Sinatra::Reloader

    require_relative 'lib/babel'
    use Sass::Plugin::Rack
    use Babel
  end

  helpers do
    def partial(id, title, variables = {})
      layout_vars = {id: id, title: title}

      layout_vars[:script] =
        if File.exist?(File.expand_path("../public/javascripts/#{id}.js", __FILE__))
          "<script src='/javascripts/#{id}.js'></script>"
        else
          nil
        end

      layout_vars[:stylesheet] =
        if File.exist?(File.expand_path("../public/stylesheets/sass/#{id}.scss", __FILE__))
          "<link href='/stylesheets/#{id}.css' rel='stylesheet'>"
        else
          nil
        end

      haml(id, locals: layout_vars.merge(variables))
    end
  end

  get '/' do
    partial :index, 'Home', {
      icons: {
        github: 'https://github.com/MiningPotatoes',
        envelope: 'mailto:nick@nickclifford.me'
      },
      projects: YAML.load_file(File.expand_path('../projects.yaml', __FILE__))
    }
  end
end
