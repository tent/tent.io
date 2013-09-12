require 'yajl'

module TentDoc
  class APIExample
    def self.compile(data, options = {})
      new(data, options).compile
    end

    DEFAULT_OPTIONS = {
      :path => File.expand_path("../../../source/docs/api_examples.json", __FILE__)
    }.freeze

    attr_reader :data, :options

    def initialize(data, options = {})
      @data = data

      @options = DEFAULT_OPTIONS.merge(options)
    end

    def compile
      data.gsub(/\{(\w+) example\}/) { api_examples[$1] }
    end

    private

    def api_examples
      @api_examples ||= Yajl::Parser.parse(
        File.read(options[:path])
      )
    end
  end
end
