include Nanoc::Helpers::LinkTo

def nav_link_with_active(text, target, attributes = {})
  target_path = target.is_a?(String) ? target : target.path
  item_path = @item_rep.path.sub(/\..+/, '')

  active = if attributes.delete(:top)
             /^#{target_path}/ =~ item_path
           else
             target_path == item_path
           end

  "<li #{'class="active"' if active}>" + link_to(text, target, attributes) + "</li>"
end
