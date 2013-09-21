lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'tilt/tent_doc'
require 'markdown_html'

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

set :markdown_engine, :redcarpet
set :markdown,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      tables: true,
      strikethrough: true,
      lax_html_blocks: true,
      space_after_headers: true,
      superscript: true

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

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :gzip
end
