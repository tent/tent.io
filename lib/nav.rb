include Nanoc::Helpers::LinkTo

def nav_link_with_active(text, target, attributes = {})
  path = target.is_a?(String) ? target : target.path
  rep_path = @item_rep.path

  active = if path == '/'
             path == rep_path
           else
             /^#{path}/ =~ rep_path
           end

  "<li #{'class="active"' if active}>" + link_to(text, target, attributes) + "</li>"
end
