module TentDoc
  class SchemaTable
    class HTMLElement
      attr_accessor :name, :content, :attributes

      def initialize(name, content = '', attributes = {})
        @name, @content, @attributes = name, content, attributes
      end

      def <<(content)
        self.content << content
      end

      def to_html
        if attributes.keys.any?
          attrs = ' ' + attributes.map {
            |k,v| %(#{k}="#{v}")
          }.join(' ')
        else
          attrs = ''
        end

        %(<#{name}#{attrs}>\n#{content}\n</#{name}>\n)
      end
    end
  end
end
