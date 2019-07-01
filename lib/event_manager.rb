
require "csv"

def clean_zipcode(zipcode)
  if zipcode.nil?
    zipcode = "00000"
  elsif zipcode.length < 5
    zipcode = zipcode.rjust 5, "0"
  elsif zipcode.length > 5
    zipcode = zipcode[0..4]
  else 
    zipcode
  end
end

puts "EventManager Initialized!"

content = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
content.each do | row |
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])
  
  puts "#{name} #{zipcode}"
end