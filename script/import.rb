require 'net/http'
require 'nokogiri'
require 'yaml'

YAML::ENGINE.yamler = 'psych'

class DemonymsData
  def self.data_dir
    @data_dir ||= File.expand_path('../../tmp', __FILE__)
  end

  def self.wiki_domain(locale='en')
    "#{locale}.wikipedia.org"
  end

  def self.data_urls
    { primary: "/wiki/List_of_adjectival_and_demonymic_forms_of_place_names",
      countries: "/wiki/List_of_adjectival_and_demonymic_forms_for_countries_and_nations",
      us_states: "/wiki/List_of_demonyms_for_U.S._states" }
  end

  def self.download
    self.data_urls.each_pair do |file_name, path|
      dest = File.join(data_dir, "#{file_name}.html")
      data = Net::HTTP.get(wiki_domain, path)
      mode = "w+"

      File.open(dest, mode) { |f| f << data }
    end
  end

  def data_file(name)
    File.read(File.join(self.class.data_dir, "#{name}.html"))
  end

  attr_accessor :primary, :countries, :us_states
  def initialize
    @primary = Nokogiri::HTML.parse(data_file(:primary))
    @countries = Nokogiri::HTML.parse(data_file(:countries))
    @us_states = Nokogiri::HTML.parse(data_file(:us_states))
  end
end

class FindDemonym
  attr_accessor :data
  def initialize(data)
    @data = data
  end

  def for_country_name(country_name)
    clean_country_name = country_name #.gsub(/[^a-zA-z0-9]/, '')
    country_link = data.countries.css("a[title*='#{clean_country_name}']").first

    if country_link.nil?
      puts "Couldn't find matching link for #{country_name} (#{clean_country_name})"
      return nil
    end

    if row = country_link.ancestors("tr").first
      columns = row.css('td')

      if columns[1].respond_to?(:css)
        link = columns[1].css("a").first

        if link.nil?
          first_word_in_column = columns[1].text.split(' ').first
          return first_word_in_column
        else
          return link.text
        end
      else
        puts "Couldn't find adjective column for #{country_name} (#{clean_country_name})"
        return nil
      end
    else
      puts "Couldn't traverse to a row for #{country_name} (#{clean_country_name})"
      return nil
    end

    return nil
  rescue
    puts "Error while finding demonym for country: #{country_name}"
    puts $!
    return nil
  end
end

class WorldData
  attr_accessor :data, :find_demonym

  def initialize
    @data = { 'en' => { 'world' => {} } }
    demonym_data = DemonymsData.new
    @find_demonym = FindDemonym.new(demonym_data)
  end

  def add_demonyms
    Carmen::Country.all.each do |country|
      demonym = find_demonym.for_country_name(country.name)
      @data['en']['world'][country.code.downcase] ||= {}
      @data['en']['world'][country.code.downcase]['demonym'] = demonym
    end
  end

  def write
    path = File.expand_path("../../locale/en/world.yml", __FILE__)
    File.open(path, 'w+') { |f| f << @data.to_yaml }
  end

  def add_demonyms!
    add_demonyms
    write
  end

  def countries
    @data['en']['world'].values
  end

  def countries_without_demonym
    countries.select { |v| v['demonym'].nil? }
  end

  def count_countries_without_demonym
    countries_without_demonym.count
  end

  def count_countries
    countries.count
    @data['en']['world'].values.count
  end
end

