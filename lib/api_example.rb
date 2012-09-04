require 'tent-apidoc'

class ApiExampleFilter < Nanoc::Filter
  identifier :api_example
  type :text

  def run(content, params={})
    content.gsub(/\{(\w+) example\}/) { api_example($1) }
  end

  private

  def api_example(id)
    TentApiDoc.examples[id.to_sym]
  end
end
