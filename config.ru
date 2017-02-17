#\ -p 3692
#!/usr/bin/env ruby

require_relative 'index'

Sass::Plugin.options[:sourcemap] = :none
Sass::Plugin.options[:unix_newlines] = true
run NickCliffordV2
