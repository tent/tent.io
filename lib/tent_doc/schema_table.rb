require 'tent-schemas'
require 'tent_doc/schema_table/table'

module TentDoc
  class SchemaTable
    def self.compile(data, options = {})
      new(data, options).compile
    end

    MissingSchemaError = Class.new(StandardError)

    def self.load_schema(schema_name)
      unless schema = TentSchemas[schema_name]
        raise MissingSchemaError.new("failed to load #{schema.inspect} schema")
      end

      schema
    end

    DEFAULT_OPTIONS = {
      :table_css_classes => %w[
        table
        table-striped
        table-bordered
      ]
    }.freeze

    attr_reader :data, :options

    def initialize(data, options = {})
      @data = data

      @options = DEFAULT_OPTIONS.merge(options)
    end

    def compile
      data.gsub(/\{([\w-]+) schema\}/) { schema_table($1) }
    end

    def load_schema(schema_name)
      self.class.load_schema(schema_name)
    end

    def schema_table(schema_name)
      Table.new(schema_name, load_schema(schema_name)).to_html(options)
    end
  end
end
