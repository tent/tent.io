require 'pygments.rb'
require 'cgi'
require 'middleman-core/renderers/redcarpet'

module MarkdownHelpers
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

class Middleman::Renderers::MiddlemanRedcarpetHTML
  include Redcarpet::Render::SmartyPants
  include MarkdownHelpers

  def block_code(code, language)
    language == "text" ? el('pre', CGI::escapeHTML(code)) : Pygments.highlight(code, lexer: language)
  end

  def table(header, body)
    el('table', el('thead', header) + el('tbody', body), class: 'table table-striped table-bordered')
  end

  def header(text, level)
    el("h#{level}", text, id: anchor(text))
  end
end

class MarkdownHTMLTOC < Redcarpet::Render::Base
  include MarkdownHelpers

  def header(text, level)
    return "" if text =~ /\Alayout:/

    html = []
    @current_level ||= 2
    if level > @current_level
      @current_level.upto(level-1) { |d|
        html << "<ul class='nav nav-list'>"
        html << '<li>'
      }
    elsif level < @current_level
      html << '</li>'
      level.upto(@current_level-1) {
        html << '</ul>'
        html << '</li>'
      }
      html << '<li>'
    else
      html << '</li>'
      html << '<li>'
    end
    @current_level = level

    html << el('a', text, href: "#"+anchor(text))
    html.join("\n")
  end

  def doc_footer
    html = []
    @current_level ||= 2
    (@current_level-1).times {
      html << "</li>"
      html << "</ul>"
    }
    html.join("\n")
  end
end
