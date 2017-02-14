require 'haml'
require 'yaml'
require 'sass/plugin/rack'
require 'sinatra/base'

class NickCliffordV2 < Sinatra::Base
  configure do
    use Sass::Plugin::Rack
  end

  helpers do
    def partial(id, title, variables = {})
      haml(id, locals: {
        css: id.to_s,
        title: title
      }.merge(variables))
    end
  end

  get '/' do
    partial :index, 'Home', {
      projects: YAML.load_file(File.expand_path('../projects.yaml', __FILE__))
    }
  end
end