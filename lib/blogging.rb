module Nanoc3::Helpers::Blogging
  # Patch to add analytics param to feed urls
  alias url_for_without_analytics url_for
  def url_for(item)
    url = url_for_without_analytics(item)
    url.sub(/(\.html|\/)$/, '') + '?utm_source=feed'
  end
end
