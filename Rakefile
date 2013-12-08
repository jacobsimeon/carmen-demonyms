require "bundler/gem_tasks"
require 'carmen'

namespace :demonyms do
  task :download do
    require File.expand_path("../script/import.rb", __FILE__)
    DemonymsData.download
  end

  task :import do
    require File.expand_path("../script/import.rb", __FILE__)

    world = WorldData.new
    world.add_demonyms!
    total = world.count_countries
    without = world.count_countries_without_demonym

    puts "Unable to find demonym for #{without} of #{total} countries."
  end
end
