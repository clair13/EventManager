
require "csv"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

puts "EventManager Initialized!"

content = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
content.each do | row |
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])
  
  puts "#{name} #{zipcode}"
end