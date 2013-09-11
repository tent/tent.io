require 'tent_doc/schema_table/html_element'

module TentDoc
  class SchemaTable
    class Table
      attr_reader :schema_name, :schema

      def initialize(schema_name, schema)
        @schema_name, @schema = schema_name, schema
      end

      def post_schema?
        @post_schema ||= schema_name == 'post'
      end

      def to_html(options = {})
        table = el('table', '',
          :class => options[:table_css_classes].to_a.join(' ')
        )

        table << table_header(options).to_html
        table << table_body(options).to_html

        table.to_html
      end

      private

      def table_header(options = {})
        headers = if post_schema?
          %w[ Property Server App Type Description ]
        else
          %w[ Property Required Type Description ]
        end

        thead = el('thead')
        thead << headers.map { |header|
          el('th', header).to_html
        }.join

        thead
      end

      def table_body(options = {})
        tbody = el('tbody')

        schema['properties'].map do |name, attrs|
          tbody << property_rows(name, attrs)
        end

        tbody
      end

      def property_rows(name, attrs)
        attrs = resolve_ref(attrs['$ref'], attrs['post']) if attrs['$ref']
        type = capitalize(attrs['type'])

        if attrs['type'] == 'array'
          type += " of #{capitalize(attrs['items']['type'])}s"
        end

        main_row = el('tr')
        main_row << el('td', el('code', name))
        main_row << el('td', required_to_s(attrs['required']))
        main_row << el('td', required_to_s(attrs['app_required'])) if attrs['post']
        main_row << el('td', type)
        main_row << el('td', attrs['description'].gsub(/`([^`]+?)`/, '<code>\1</code>'))

        rows = [main_row]

        if attrs['items'] && attrs['items']['type'] == 'object' && attrs['items']['properties']
          attrs['items']['properties'].each do |k, v|
            rows << property_rows("#{name}[].#{k}", v.merge('post' => attrs['post']))
          end
        elsif attrs['properties']
          attrs['properties'].each do |k,v|
            rows << property_rows("#{name}.#{k}", v.merge('post' => attrs['post']))
          end
        end

        rows.join
      end

      def required_to_s(flag)
        case flag
        when true
          'Required'
        when 'import'
          'Import'
        else
          'Optional'
        end
      end

      def capitalize(str)
        str[0].upcase + str[1..-1]
      end

      def resolve_ref(ref, post)
        SchemaTable.load_schema(
          ref.sub('#/schemas/', '')
        ).merge('post' => post)
      end

      def el(name, content = '', attributes = {})
        HTMLElement.new(name, content, attributes)
      end
    end
  end
end
