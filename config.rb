lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'tilt/tent_doc'

begin
  # Reload the browser automatically whenever files change
  require 'middleman-livereload'
  activate :livereload
rescue LoadError
end

activate :blog do |blog|
  blog.prefix = 'blog'
  blog.permalink = ":title.html"
  blog.sources = "blog/:title.html.md"
  blog.layout = 'blog'
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Configure Sprockets
require 'fly'
Fly::Sprockets.setup(sprockets)

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :gzip
end
