require 'yaml'

class ApiExampleFilter < Nanoc::Filter
  identifier :api_example
  type :text

  DATA = YAML.load(File.read('content/docs/api_examples.yaml'))

  def run(content, params={})
    content.gsub(/\{(\w+) example\}/) { api_example($1) }.gsub(/\{(\w+) var\}/) { api_var($1) }
  end

  private

  def api_example(id)
    DATA[:examples][id.to_sym]
  end

  def api_var(id)
    DATA[:variables][id.to_sym]
  end
end
