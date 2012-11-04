require 'pygments.rb'

class MarkdownHTML < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants

  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end

  def table(header, body)
    el('table', el('thead', header) + el('tbody', body), class: 'table table-striped table-bordered')
  end

  def header(text, level)
    el("h#{level}", text, id: anchor(text))
  end

  private

  def anchor(text)
    text.downcase.strip.gsub(/[^a-z0-9 ]/, '').gsub(/\s+/, '-')
  end

  def el(el, content, attributes = {})
    if content
      attrs = attributes ? ' ' + attributes.map { |k,v| "#{k}=\"#{v}\"" }.join(' ') : ''
      "<#{el}#{attrs}>\n#{content}</#{el}>\n"
    else
      ''
    end
  end
end
