require 'tent_doc/schema_table'
require 'tent_doc/api_example'
require 'middleman-core/renderers/redcarpet'

# Piggyback on Middleman's markdown renderer
module Middleman
  module Renderers
    class RedcarpetTemplate
      PROCESSORS = {
        :schema_table => ::TentDoc::SchemaTable,
        :api_example => ::TentDoc::APIExample
      }.freeze

      alias _evaluate evaluate
      def evaluate(scope, locals, &block)
        _output = data
        _output = PROCESSORS.inject(_output) do |memo, (key, processor)|
          processor.compile(memo.to_s, options[key] || {}) || memo
        end

        @data = _output

        _evaluate(scope, locals, &block)
      end
    end
  end
end
