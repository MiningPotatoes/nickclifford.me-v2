# Bundler has to be explicitly required when using a Git URL for gems
require 'bundler/setup'
require 'babel/transpiler'
require 'json'
require 'rbconfig'

class NickCliffordV2
  # Rack middleware for transpiling ES6 JavaScript via Babel
  # inspired by Sass::Plugin::Rack (but *so* much less complicated)
  class Babel
    class << self
      def sourcemaps
        @@sourcemaps
      end

      def sourcemaps=(val)
        @@sourcemaps = val
      end
    end

    def initialize(app)
      @app = app
      @@sourcemaps = true unless defined? @@sourcemaps
    end

    def call(env)
      Dir.glob(File.expand_path('../src/es6/*.es6', __dir__)) do |filename|
        transpile_name = File.expand_path("../public/javascripts/#{File.basename(filename, '.*')}.js", __dir__)

        # do not retranspile if there have been no modifications to the original ES6 file since transpilation
        next if File.exist?(transpile_name) && File.mtime(filename) < File.mtime(transpile_name)

        babel = ::Babel::Transpiler.transform(File.read(filename), {
          'comments' => false,
          'sourceFileName' => '../../src/es6/' + File.basename(filename),
          'sourceMaps' => true,
          'sourceMapTarget' => File.basename(transpile_name)
        })

        flag = 'w'
        flag << 'b' if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/ # write LF instead of CRLF on Windows
        
        File.open(transpile_name, flag) do |js|
          js.puts(babel['code'])

          if @@sourcemaps
            map_name = transpile_name + '.map'
            js.puts("//# sourceMappingURL=#{File.basename(map_name)}")

            File.open(map_name, flag) do |map|
              babel['map'].delete('sourcesContent') # this key isn't necessary at all, so let's delete it
              map.puts(JSON.dump(babel['map']))
            end
          end
        end
      end

      @app.call(env)
    end
  end
end
