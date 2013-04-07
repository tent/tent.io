require 'tent-schemas'

class SchemaTableFilter < Nanoc::Filter
  identifier :schema_table
  type :text

  def run(content, params={})
    content.gsub(/\{(\w+) schema\}/) { schema_table($1) }
  end

  private

  def table_header
    el('thead', %w(Property Server App Type Description).map { |v| el('th', v) }.join)
  end

  def schema_table(schema)
    el('table', table_header + el('tbody', TentSchemas[schema]['properties'].map { |k,v| property_rows(k, v) }.join), class: 'table table-striped table-bordered')
  end

  def property_rows(name, attrs)
    type = capitalize(attrs['type'])
    if attrs['type'] == 'array'
      type += " of #{capitalize(attrs['items']['type'])}s"
    end

    attrs = resolve_ref(attrs['$ref']) if attrs['$ref']
    rows = [el('tr',
             el('td', el('code', name)) +
             el('td', required(attrs['required'])) +
             el('td', required(attrs['app_required'])) +
             el('td', type) +
             el('td', attrs['description'])
            )]
    if attrs['items'] && attrs['items']['type'] == 'object'
      attrs['items']['properties'].each { |k,v| rows << property_rows("#{name}[].#{k}", v)}
    elsif attrs['properties']
      attrs['properties'].each { |k,v| rows << property_rows("#{name}.#{k}", v)}
    end

    rows.join
  end

  def required(flag)
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

  def resolve_ref(ref)
    TentSchemas[ref.sub('#/schemas/', '')]
  end

  def el(el, content, attributes = {})
      attrs = attributes ? ' ' + attributes.map { |k,v| "#{k}=\"#{v}\"" }.join(' ') : ''
      "<#{el}#{attrs}>\n#{content}</#{el}>\n"
  end
end
