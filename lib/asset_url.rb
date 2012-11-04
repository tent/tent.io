module Nanoc3::Helpers::AssetURL
  def asset_url(path, options = {})
    name, extension = path.match(/([^.]+).(.+)$/).to_a[1..-1]
    extensions = extension.split('.')

    asset_dir = options[:asset_dir] || extensions.first

    filename = "content/assets/#{asset_dir}/#{name}.#{extension}"
    fp = fingerprint(filename)

    path = "/assets/#{asset_dir}/#{name}#{fp}.#{extensions[0..extensions.size-2].join('.')}"
    if ENV['USE_CDN']
      @site.config[:cdn_url] + path
    else
      path
    end
  end

  def image_url(path)
    asset_url(path, :asset_dir => 'images')
  end
end
