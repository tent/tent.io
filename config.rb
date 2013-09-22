lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'tilt/tent_doc'
require 'markdown_html'
require 'builder'

begin
  # Reload the browser automatically whenever files change
  require 'middleman-livereload'
  activate :livereload
rescue LoadError
end

activate :blog do |blog|
  blog.permalink = "blog/:title.html"
  blog.sources = "blog/:title.html"
  blog.layout = 'blog_layout'
  blog.default_extension = '.md'

  blog.paginate = true
  blog.page_link = "pages/:num"
  blog.publish_future_dated = true
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, REDCARPET_EXTENTIONS

helpers do
  def nav_link_with_active(text, target, attributes = {})
    target_path = target
    item_path = current_page.url.sub(/([^\/]+)\/\Z/, '\1')

    active = if attributes.delete(:top)
               /^#{target_path}/ =~ item_path
             else
               target_path == item_path
             end

    "<li #{'class="active"' if active}>" + link_to(text, target, attributes) + "</li>"
  end
end

# Configure Sprockets
require 'fly'
Fly::Sprockets.setup(sprockets)

require 'sprockets-helpers'
::Sprockets::Helpers.configure do |config|
  config.environment = sprockets
end

sprockets.context_class.class_eval do
  include ::Sprockets::Helpers

  alias _font_path font_path
  def font_path(source, options = {})
    options[:prefix] = "/fonts"
    _path = asset_path source, ::Sprockets::Helpers.default_path_options[:font_path].merge(options)
    _path
  end
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :gzip
end
