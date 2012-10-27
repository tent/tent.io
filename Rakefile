require 'bundler/setup'

task :gzip_assets do
  Dir['output/assets/**/*.*'].reject { |f| f =~ /\.gz\z/ }.each do |f|
    sh "gzip -c #{f} > #{f}.gz" unless File.exist?("#{f}.gz")
  end
end

task :deploy_assets => :gzip_assets do
  require './config/asset_sync'
  AssetSync.sync
end
