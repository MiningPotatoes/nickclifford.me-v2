require "sass"

class SassHandler < Kemal::Handler
  def call(context)
    Dir.glob("./scss/*.scss")
       .reject {|a| File.basename(a).starts_with?('_')}
       .each do |filename|
      css_name = "./public/css/#{File.basename(filename, ".scss")}.css"

      # Do not recompile if there have been no modifications to the original SCSS file since compilation
      next if File.exists?(css_name) && File.info(filename).modification_time < File.info(css_name).modification_time

      css = Sass.compile_file(
        filename,
        source_comments: false,
        input_path: filename,
        output_path: css_name,
        # As of right now, sass.cr doesn't allow me to create separate sourcemap files
        # source_map_embed: Kemal.config.env == "development"
      )

      Dir.mkdir("./public/css") unless Dir.exists?("./public/css")
      File.write(css_name, css)
    end

    call_next context
  end
end

add_handler SassHandler.new
