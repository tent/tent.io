require 'open3'

# This nanoc filter is a general purpose filter that simply pipes
# the contents of an item into a given shell command, and sets
# the items output to the output of it.
#
# It is NOT safe to use on large inputs, which will cause I/O
# deadlocks. Any safer implementation is encouraged.
#
# Usage:
#
# compile '/static/js/*/' do
# # minify JS :)
# filter :shellcmd, "java -jar js-compiler.jar"
# end
#
# Written by Vincent Driessen (http://twitter.com/nvie) and
# released to the public domain.
#
# http://nvie.com
class ShellCmdFilter < Nanoc3::Filter
  identifier :shellcmd

  def run(content, params)
    Open3.popen3(params[:cmd]) do |stdin, stdout, stderr|
      stdin.write(content)
      stdin.close
      stdout.read
    end
  end
end
