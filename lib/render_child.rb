def render_child(name)
  child = @item.children.find { |child| child.identifier == name }
  child.reps.find { |rep| rep.name == :default }.content_at_snapshot(:last)
end
