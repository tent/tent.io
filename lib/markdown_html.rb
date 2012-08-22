require 'pygments.rb'

RubyPython.start python_exe: 'python2.6' if ENV['RACK_ENV'] == 'production'

class MarkdownHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end
end
