require 'fileutils'

class LanguagePack::Custom < LanguagePack::Rack
  def self.use?
    true
  end

  def name
    "Nanoc"
  end

  # hack to hook into ruby pack 
  def run_assets_precompile_rake_task
    require 'benchmark'
    topic "Compiling nanoc site"

    cache_clear 'output' if ENV['CLEAR_CACHE']

    puts "Found cached output directory." if cache_load 'output'
    time = Benchmark.realtime { pipe("env PATH=$PATH:vendor/pygments:bin bundle exec nanoc compile") }

    if $?.success?
      cache_store 'output'
      puts "Nanoc compilation completed (#{"%.2f" % time}s)"
    else
      exit $?.to_i
    end
  end
end
