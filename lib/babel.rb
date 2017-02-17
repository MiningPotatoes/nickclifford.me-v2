# Bundler has to be explicitly required when using a Git URL for gems
require 'bundler/setup'
require 'babel/transpiler'
require 'rbconfig'

class NickCliffordV2
  # Rack middleware for transpiling ES6 JavaScript via Babel
  # inspired by Sass::Plugin::Rack (but *so* much less complicated)
  class Babel
    def initialize(app)
      @app = app
    end

    def call(env)
      Dir.glob(File.expand_path('../public/javascripts/es6/*.es6', __dir__)) do |filename|
        transpile_name = File.expand_path("../public/javascripts/#{File.basename(filename, '.*')}.js", __dir__)

        # do not retranspile if there have been no modifications to the original ES6 file since transpilation
        next if File.exist?(transpile_name) && File.mtime(filename) < File.mtime(transpile_name)

        flag = 'w'
        flag << 'b' if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/ # write LF instead of CRLF on Windows

        babel = ::Babel::Transpiler.transform(File.read(filename), {
          'comments' => false
        })
        
        File.open(transpile_name, flag) {|f| f.puts(babel['code'])}
      end

      @app.call(env)
    end
  end
end
