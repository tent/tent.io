require 'pygments.rb'

RubyPython.start python_exe: 'python2.6' if ENV['RACK_ENV'] == 'production'

class MarkdownHTML < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants

  def initialize(options={})
    super options.merge(with_toc_data: true)
  end

  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end
end
