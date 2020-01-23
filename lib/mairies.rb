require 'rubygems'
require 'nokogiri'
require 'open-uri'

url_valdoise = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

#FONCTION get_townhall_urls(url_valdoise)
#1 cree l'array final vide
#2 prend tous les liens de url valdoise qui contiennent .95 (contenus dans la classe href) et pour chaque ajoute le préfixe annuaire des mairies(avec le point supprimé)

#3 on décortique url_name qui correspond à (par ex: <a class="lientxt" href="./95/sagy.html">SAGY</a>) pour récuperer ce que l'on veut séparément
#ici on recupere l'url : url_name['href'] 
#ici on recupere le nom de la ville : name = url_name.text 

#4 on fait appel à la fonction enfant du dessous pour chopper les mails de chaque page de mairie, elle va avoir besoin de 
#full _url qui va changer a chaque nouvelle mairie, on a besoin de name (nom de chaque ville) qui varie aussi et de array final pour y envoyer nos petits hash


def get_townhall_urls(url_valdoise)
  array_final = []
  cities = url_valdoise.xpath('//a[contains(@href, "./95")]')
  cities.map do |url_name|
    puts url_name
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

#FONCTION get_townhall_mail
#1 va sur la page generale de toutes les mairies, on a besoin d'avoir un nokogiri html dynamique on le remet dans cette fonction
#et va retrouver la full_url construite en dans la premiere fonction
#2 cherche un arobase sur la page de chaque mairie
#3 met dans l'array finale qui contiendra tous les noms + email a chaque tour le mini hash name + email
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

