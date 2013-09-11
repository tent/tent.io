require 'tent_doc/schema_table'
require 'tent_doc/api_example'

module TentDoc
  PROCESSORS = {
    :schema_table => SchemaTable,
    :api_example => APIExample
  }.freeze

  def self.compile(data, options = {})
    PROCESSORS.inject(data) do |data, (key, processor)|
      processor.compile(data, options[key] || {})
    end
  end
end

::Tilt.register(TentDoc, 'tent_doc')
