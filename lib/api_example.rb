require 'yaml'

class ApiExampleFilter < Nanoc::Filter
  identifier :api_example
  type :text

  def initialize(*args)
    @data = YAML.load(File.read('content/docs/api_examples.yaml'))
  end

  def run(content, params={})
    content.gsub(/\{(\w+) example\}/) { api_example($1) }.gsub(/\{(\w+) var\}/) { api_var($1) }
  end

  private

  def api_example(id)
    @data[:examples][id.to_sym]
  end

  def api_var(id)
    @data[:variables][id.to_sym]
  end
end
