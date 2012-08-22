require 'nanoc/cachebuster'
require 'slim'
require 'redcarpet'

include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::XMLSitemap
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::CacheBusting

Slim::Engine.set_default_options pretty: true
