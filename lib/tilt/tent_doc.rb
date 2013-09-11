require 'tilt/template'
require 'tent_doc'

module Tilt
  class TentDocTemplate < Template
    def evaluate(scope, locals, &block)
      ::TentDoc.compile(data)
    end
  end
end

