require 'tent-schemas'

class SchemaTableFilter < Nanoc::Filter
  identifier :schema_table
  type :text

  def run(content, params={})
    content.gsub(/\{(\w+) schema\}/) { schema_table($1) }
  end

  private

  def schema_table(schema)
    table = [['Property', 'Required', 'Type', 'Description']]
    table << ['---'] * table.first.size
    table += properties_table(TentSchemas[schema]['properties'])
    table.map { |r| r.unshift(nil).push(nil).join(' | ').strip }.join("\n")
  end

  def properties_table(properties)
    properties.map do |prop,attrs|
      attrs = resolve_ref(attrs['$ref']) if attrs['$ref']
      ["`#{prop}`", attrs['required'] ? 'Required' : 'Optional', capitalize(attrs['type']), attrs['description']]
    end
  end

  def capitalize(str)
    str[0].upcase + str[1..-1]
  end

  def resolve_ref(ref)
    TentSchemas[ref.sub('#/schemas/', '')]
  end
end
