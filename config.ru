require 'bundler/setup'
require 'cgi'
require 'rack/static'
require 'rack/deflater'
require 'rack/rewrite'
require 'clogger'

ONE_YEAR = 31_556_926

class AssetExpires
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers.merge!('Cache-Control' => "max-age=#{ONE_YEAR}, public", 'Expires' => CGI.rfc1123_date(Time.now + ONE_YEAR)) if asset?(env)
    [status, headers, body]
  end

  private

  def asset?(env)
    %w(js css jpg jpeg png gif).include?(env['PATH_INFO'].split('.').last) && env['PATH_INFO'] =~ /-cb/
  end
end

class ContentTypeCharset
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers['Content-Type'] += ';charset=utf-8' unless headers['Content-Type'] =~ /charset/ || headers['Content-Type'].nil?
    [status, headers, body]
  end
end

# modified from https://github.com/meskyanichi/nanoc-heroku/blob/master/config.ru
class TryStatic < Rack::Static
  def initialize(app, options)
    super
    @try = ([''] + Array(options.delete(:try)) + [''])
  end

  def call(env)

    @next = 0
    while @next < @try.size && 404 == (resp = super(try_next(env)))[0]
      @next += 1
    end

    resp
  end

  private

  def try_next(env)
    env.merge('PATH_INFO' => env['PATH_INFO'] + @try[@next])
  end
end

use Clogger, format: :NginxCombined, logger: STDOUT, reentrant: true if ENV['RACK_ENV'] == 'production'
use Rack::Rewrite do
  r301 %r{.*}, 'http://tent.io$&', if: Proc.new { |env|
    env['SERVER_NAME'] != 'tent.io' && !env['QUERY_STRING'].include?('skip_redirect')
  } if ENV['RACK_ENV'] == 'production'

  r301 %r{(.+)(/|\.html)$}, '$1'
  r302 %r{\A/types/post/.+}, '/docs/post-types'
  r302 %r{\A/types/info/.+}, '/docs/info-types'
end

use Rack::Deflater
use AssetExpires
use ContentTypeCharset
use TryStatic, root: 'output', urls: %w[/], try: %w(.html index.html /index.html)

run lambda { |env| [404, {}, ''] }
