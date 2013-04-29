require 'json'

class ApiExampleFilter < Nanoc::Filter
  identifier :api_example
  type :text

  def initialize(*args)
    @data = JSON.parse(File.read('content/docs/api_examples.json'))
  end

  def run(content, params={})
    content.gsub(/\{(\w+) example\}/) { @data[$1] }
  end
end
