require 'rubygems'
require 'nokogiri'
require 'open-uri'

url_valdoise = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

# puts page.css('title')[0].name  # => Nokogiri::HTML::Document

def get_townhall_urls(url_valdoise)
  array_final = []
  cities = url_valdoise.xpath('//a[contains(@href, "./95")]')
  cities.map do |url_name|
    full_url = "https://www.annuaire-des-mairies.com/" + "#{url_name['href'].delete_prefix!("./")}"
    name = url_name.text
    # puts full_url
    # puts name
    get_townhall_mail(full_url, name, array_final)
  rescue
    puts "#{name} n'a pas d'email"
  end
  puts array_final
end

def get_townhall_mail(full_url, name, array_final)
  general_townhall = Nokogiri::HTML(open(full_url))
  townhall_mail = general_townhall.at('td:contains("@")').text.strip
  array_final << {name => townhall_mail}
end

puts get_townhall_urls(url_valdoise)


# townhall_mail_array = []
# townhall_mail.each do |mot|
#   mot = mot.text
#   townhall_mail_array << mot 
# end


# print townhall_mail_array.select {|element| element.include? "@" }


# get_townhall_email(townhall_url)

