
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
# puts page.css('title')[0].name  # => Nokogiri::HTML::Document


crypto_names= page.xpath('//td[@class ="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]/div/text()')


crypto_values = page.xpath('//td[@class ="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/a/text()')

crypto_names_array = []
crypto_names.each do |name|  
  name = name.text
  crypto_names_array << name
end

# print crypto_names_array

crypto_values_array = []
crypto_values.each do |value|  
  value = value.text.delete!("$").to_f
  crypto_values_array << value
end

# print crypto_values_array


# crypto_hash = Hash.new
# [:crypto_names_array] = crypto_values_array

currency_result = Hash[crypto_names_array.zip(crypto_values_array)]

# currency_result = [crypto_names_array, crypto_values_array].transpose.to_h
puts currency_result

# puts currency_result

currency_array = []

currency_array << currency_result.map {|key, value| {key => value}}

print currency_array 


