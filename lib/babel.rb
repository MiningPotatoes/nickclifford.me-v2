# Bundler has to be explicitly required when using a Git URL for gems
require 'bundler/setup'
require 'babel/transpiler'
require 'json'
require 'rbconfig'

class NickCliffordV2
  # Rack middleware for transpiling ES6 JavaScript via Babel
  class Babel
    def initialize(app)
      @app = app
    end

    def call(env)
      # do all the important stuff
      Dir.glob('../public/javascripts/es6/*.es6') do |filename|
        transpiled = "../public/javascripts/#{File.basename(filename, '.*')}.js"

        next if !File.exist?(transpiled) # TODO: check if updated

        flag = 'w'
        flag << 'b' if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
        # TODO: transpile all the stuff
      end
      @app.call(env)
    end
  end
end