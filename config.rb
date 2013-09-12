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
  blog.permalink = ":title"
  blog.sources = "blog/:title.html"
  blog.layout = 'blog'
  blog.default_extension = '.md'

  blog.paginate = true
  blog.page_link = "page-:num"
  blog.per_page = 1
end

# Pretty URLs
activate :directory_indexes

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
