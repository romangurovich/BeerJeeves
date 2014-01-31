require 'open-uri'
require 'json'

class ImportBeersJob
  def self.perform
    pages = 524
    api_key = 'fa2271f4554ffb7d003e0a9737ca94af'

    1.upto(pages) do |page|
      api_url = "http://api.brewerydb.com/v2/beers?key=#{api_key}&p=#{page}"
      response = JSON.parse(open(api_url).read)
      make_beer(response['data'])
    end
  end

  private
  
  def self.make_beer(data)
    data.each do |beer|
      name = beer['name']
      ibu = get_beer_property('ibu', beer)
      abv = get_beer_property('abv', beer)
      category = (beer['style'] && beer['style']['name']) ? beer['style']['name'] : nil

      Beer.create!({name: name, ibu: ibu, abv: abv, category: category})
    end
  end

  def self.get_beer_property(prop_name, beer)
    prop_name = prop_name.downcase
    raise "invalid property" unless ['ibu', 'abv'].include? prop_name

    if beer[prop_name]
      beer[prop_name].to_f
    elsif (beer['style'] && beer['style']["#{prop_name}Min"] && beer['style']["#{prop_name}Max"])
      (beer['style']["#{prop_name}Max"].to_f + beer['style']["#{prop_name}Min"].to_f) / 2.0
    else
      nil
    end
  end
end
